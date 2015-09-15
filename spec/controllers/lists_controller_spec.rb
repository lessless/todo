require 'rails_helper'
require_relative 'shared_examples/lists'

RSpec.describe ListsController, type: :controller do

  let(:author)            { FactoryGirl.create(:user) }
  let(:collaborator)      { FactoryGirl.create(:user) }
  let(:random_guy)        { FactoryGirl.create(:user) }
  let!(:list)              { FactoryGirl.create(:list, author_id: author.id) }
  let(:valid_session)     { {} }


  context "author" do
    before(:each) { inject_current_user(subject, author) }

    it_behaves_like 'authorized user'
  end

  context "collaborator" do
    before(:each) do
      inject_current_user(subject, collaborator)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::LIST_READ_ACTION)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::LIST_DELETE_ACTION)
    end

    it_behaves_like 'authorized user'
  end

  context 'random guy' do
    before(:each) { inject_current_user(subject, random_guy) }

    it "prohibit random guy to read the list" do
      expect {
        get(:show, {:id => list.to_param}, valid_session)
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "prohibit random guy to to destroy the requested list" do
      expect {
        delete(:destroy, {:id => list.to_param}, valid_session)
      }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end
