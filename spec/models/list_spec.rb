require 'rails_helper'

RSpec.describe List, type: :model do
  let (:create_params)  { FactoryGirl.attributes_for(:list) }

  it "should have an author" do
    list = List.create(create_params)
    expect(list.errors[:author_id].length).to eq(1)
  end

  it "knows it's author" do
    author  = FactoryGirl.build_stubbed(:user)
    random  = FactoryGirl.build_stubbed(:user)
    list    = FactoryGirl.build_stubbed(:list, author: author)

    expect(list.created_by?(author)).to be_truthy
    expect(list.created_by?(random)).to be_falsy
  end
end
