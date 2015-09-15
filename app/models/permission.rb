class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  LIST_READ_ACTION   = 'list_read'
  LIST_DELETE_ACTION = 'list_delete'
  ITEM_CREATE_ACTION = 'item_create'
  ITEM_DELETE_ACTION = 'item_delete'

  ACTION_LIST = [ LIST_READ_ACTION, LIST_DELETE_ACTION, ITEM_CREATE_ACTION, ITEM_DELETE_ACTION ].freeze

  validates_inclusion_of :action, in: ACTION_LIST
  validates :action, uniqueness: { scope: [:user_id, :list_id] }

  scope :allowed_actions, -> (user, list) {where(user: user, list: list).pluck(:action)}
end
