# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permission do
    list_read     false
    list_delete   false
    item_create   false
    item_delete   false
    user          nil
    list          nil
    author        false
  end
end
