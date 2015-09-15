require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { FactoryGirl.build_stubbed(:user) }

  it "have todo list" do
    first_list = "First List"
    user.lists << FactoryGirl.build_stubbed(:list, name: first_list)
    expect(user.lists.map(&:title)).to eq([first_list])
  end
end
