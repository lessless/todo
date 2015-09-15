require 'rails_helper'

RSpec.describe Item, type: :model do
  let (:create_params)  { FactoryGirl.attributes_for(:item) }

  it "should belong to list" do
    list = Item.create(create_params)
    expect(list.errors[:list_id].length).to eq(1)
  end

end
