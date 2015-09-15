require 'rails_helper'

RSpec.describe Permission, type: :model do
  let (:author)          { FactoryGirl.create(:user)                 }
  let (:collaborator)    { FactoryGirl.create(:user)                 }
  let (:list )           { FactoryGirl.create(:list, author: author) }

  it "store only one action type per collaborator/list pair" do
    action = Permission::ACTION_LIST.first
    permission = Permission.create!(user: collaborator, list: list, action: action)

    expect(permission_exists?(list, collaborator, action)).to be_truthy

    expect{Permission.create!(user: collaborator, list: list, action: action)}.to  raise_error(ActiveRecord::RecordInvalid)
  end

  it "accepts only valid actions" do
    expect{Permission.create!(user: collaborator, list: list, action: "strictly random")}.to  raise_error(ActiveRecord::RecordInvalid)
  end

  it "fetches allowed actions for collaborator" do
    actions = [Permission::ACTION_LIST.first, Permission::ACTION_LIST.last]
    actions.each do |action|
      Permission.create!(user: collaborator, list: list, action: action)
    end

    expect(Permission.allowed_actions(collaborator, list)). to eq(actions)
  end
end

