require 'rails_helper'

RSpec.describe Permission, type: :model do
  let (:author)          { FactoryGirl.create(:user)                 }
  let (:collaborator)    { FactoryGirl.create(:user)                 }
  let (:list )           { FactoryGirl.create(:list, author: author) }
  let (:add_collab)      { Lists::AddCollaborator.new(list)          }

  it "store only one action type per collaborator/list pair" do
    permission = Permission::ACTIONS.first

    add_collab.execute!(collaborator, permission)
    expect(check_permission(list, collaborator, permission)).to be_truthy

    expect{add_collab.execute!(collaborator, permission)}.to  raise_error(ActiveRecord::RecordInvalid)
  end

  it "accepts only valid actions" do
    expect{add_collab.execute!(collaborator, "strictly random")}.to  raise_error(ActiveRecord::RecordInvalid)
  end
end
