require 'rails_helper'

RSpec.describe ListPolicy do
  subject { described_class }

  let (:author)       { FactoryGirl.create(:user)                 }
  let (:random_guy)   { FactoryGirl.create(:user)                 }
  let (:list )        { FactoryGirl.create(:list, author: author) }

  permissions :show? do
    it "allow author to read list" do
       expect(subject).to permit(author, list)
    end

    it "doesn't allow random guy to read list" do
       expect(subject).not_to permit(random_guy, list)
    end

    it "allow collaborator to read the list" do
      collaborator = FactoryGirl.create(:user)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::LIST_READ_ACTION)
      expect(subject).to permit(collaborator, list)
    end
  end

  permissions :delete? do
    it "allow author to read list" do
       expect(subject).to permit(author, list)
    end

    it "doesn't allow random guy to read list" do
       expect(subject).not_to permit(random_guy, list)
    end

    it "allow collaborator to read the list" do
      collaborator = FactoryGirl.create(:user)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::LIST_DELETE_ACTION)
      expect(subject).to permit(collaborator, list)
    end
  end
end
