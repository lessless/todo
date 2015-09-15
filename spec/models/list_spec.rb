require 'rails_helper'

RSpec.describe List, type: :model do
  let (:create_params)  { FactoryGirl.attributes_for(:list) }

  it "should have an author" do
    list = List.create(create_params)
    expect(list.errors[:author_id].length).to eq(1)
  end
end
