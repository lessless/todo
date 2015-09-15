require 'rails_helper'
require_relative 'shared_examples/items_controller'

RSpec.describe ItemsController, type: :controller do

  let(:author)              { FactoryGirl.create(:user) }
  let(:collaborator)        { FactoryGirl.create(:user) }
  let(:random_guy)          { FactoryGirl.create(:user) }
  let(:list)                { FactoryGirl.create(:list, author_id: author.id) }
  let!(:item)               { FactoryGirl.create(:item, list_id: list.id) }
  let!(:valid_attributes)   { FactoryGirl.attributes_for(:item, list_id: list.id) }
  let!(:invalid_attributes) { FactoryGirl.attributes_for(:item, list_id: list.id, title: '') }
  let(:valid_session)       { {} }

  context 'list author' do
    before(:each) { inject_current_user(subject, author) }

    it_behaves_like 'authorized user'
  end

  context 'collaborator' do
    before(:each) do
      inject_current_user(subject, collaborator)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::ITEM_CREATE_ACTION)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::ITEM_DELETE_ACTION)
    end

    it_behaves_like 'authorized user'
  end

  context 'random guy' do
    before(:each) { inject_current_user(subject, random_guy) }

    it "can't create the item" do
      expect {
        post :create, {:item => valid_attributes}, valid_session
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "can't destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
