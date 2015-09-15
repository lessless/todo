class ListPolicy

  def initialize(user, list)
    @author       = list.created_by?(user)
    @permissions  = Permission.allowed_actions(user, list)
  end

  def show?
    @author || @permissions.include?(Permission::LIST_READ_ACTION)
  end

  def delete?
    @author || @permissions.include?(Permission::LIST_DELETE_ACTION)
  end
end
