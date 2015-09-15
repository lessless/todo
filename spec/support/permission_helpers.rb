module PermissionHelpers
  def permission_exists?(list, collaborator, action)
    relations = Permission.where(list_id: list.id, user_id: collaborator.id, action: action)

    relations.length == 1
  end
end

RSpec.configure do |c|
  c.include PermissionHelpers
end
