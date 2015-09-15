require 'rails_helper'

RSpec.describe Lists::AddCollaborator do
  let (:author)       { FactoryGirl.create(:user)                 }
  let (:collaborator) { FactoryGirl.create(:user)                 }
  let (:list )        { FactoryGirl.create(:list, author: author) }
  let (:service)      { Lists::AddCollaborator.new(list)          }

  it "adds collaborator  with valid action" do
    Permission::ACTIONS.each do |action|
      service.execute!(collaborator, action)
      expect(check_permission(list, collaborator, action)).to be_truthy
    end
  end

end
