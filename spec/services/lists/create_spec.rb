require 'rails_helper'

RSpec.describe Lists::Create do
  let (:user)         { FactoryGirl.create(:user)               }
  let (:list_params)  { FactoryGirl.attributes_for(:list)       }
  let (:permission)   { FactoryGirl.attributes_for(:permission) }
  let (:service)      { Lists::Create.new(user)                 }

  before(:each) { @list = service.execute!(list_params) }

  it 'assign author on creation' do
    expect(@list.author.id).to eq(user.id)
  end

  it "correctly sets attirbutes" do
    expect(@list.name).to eq(list_params[:name])
  end
end
