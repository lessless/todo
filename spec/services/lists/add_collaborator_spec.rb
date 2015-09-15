require 'rails_helper'

RSpec.describe Lists::AddCollaborator do
  let (:author)       { FactoryGirl.create(:user)                 }
  let (:collaborator) { FactoryGirl.create(:user)                 }
  let (:list )        { FactoryGirl.create(:list, author: author) }
  let (:service)      { Lists::AddCollaborator.new(list)          }

  it "adds collaborator  with valid action" do
    Permission::ACTION_LIST.each do |action|
      service.execute!(collaborator, action)
      expect(permission_exists?(list, collaborator, action)).to be_truthy
    end
  end

  xit "accepts multiple policies as array" do
    permissions = [Permission::ACTION_LIST.first, Permission::ACTION_LIST.first]
    subject.execute!(collaborator, permissions)
    expect(list.policies.map(&:action)).to eq(permissions)
  end

  xit "doesn't save anything if there is an invalid action in the batch" do
  end

end
