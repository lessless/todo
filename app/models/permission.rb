class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :list


  ACTIONS = %w(list_read list_delete item_create item_delete)

  validates_inclusion_of :action, in: ACTIONS
  validates :action, uniqueness: { scope: [:user_id, :list_id] }
end
