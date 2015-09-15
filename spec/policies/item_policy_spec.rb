require 'rails_helper'

RSpec.describe ItemPolicy do
  subject { described_class }

  let (:author)     { FactoryGirl.build_stubbed(:user)                 }
  let (:random_guy) { FactoryGirl.build_stubbed(:user)                 }
  let (:list)       { FactoryGirl.build_stubbed(:list, author: author) }
  let (:item)       { FactoryGirl.build_stubbed(:item, list: list)     }

  permissions :create? do
    it "allow list author to create item" do
       expect(subject).to permit(author, item)
    end

    it "doesn't allow random guy to create list item" do
       expect(subject).not_to permit(random_guy, item)
    end

    it "allow collaborator to create list item" do
      collaborator = FactoryGirl.build_stubbed(:user)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::ITEM_CREATE_ACTION)

      expect(subject).to permit(collaborator, item)
    end
  end

  permissions :delete? do
    it "allow list author to item" do
       expect(subject).to permit(author, item)
    end

    it "doesn't allow random guy to delete item" do
       expect(subject).not_to permit(random_guy, item)
    end

    it "allow collaborator to delete list item" do
      collaborator = FactoryGirl.build_stubbed(:user)
      Lists::AddCollaborator.new(list).execute!(collaborator, Permission::ITEM_DELETE_ACTION)

      expect(subject).to permit(collaborator, item)
    end
  end
end
