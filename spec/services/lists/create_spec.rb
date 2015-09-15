require 'rails_helper'

RSpec.describe Lists::Create do
  let (:user)         { FactoryGirl.create(:user)               }
  let (:list_params)  { FactoryGirl.attributes_for(:list)       }
  let (:permission)   { FactoryGirl.attributes_for(:permission) }
  let (:service)      { Lists::Create.new(user)                 }

  it "assign author on creation" do
    list = service.execute!(list_params)
    expect(list.author.id). to eq(user.id)
  end
end
