class ItemPolicy
  def initialize(user, item)
    list          = item.list
    @author       = list.created_by?(user)
    @permissions  = Permission.allowed_actions(user, list)
  end

  def create?
    @author || @permissions.include?(Permission::ITEM_CREATE_ACTION)
  end

  def destroy?
    @author || @permissions.include?(Permission::ITEM_DELETE_ACTION)
  end
end
