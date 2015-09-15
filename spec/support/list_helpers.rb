module ListHelpers
  def check_permission(list, collaborator, action)
    relations = User.joins(:permissions).where(permissions: {list_id: list.id, user_id: collaborator.id, action: action})

    relations.length == 1
  end
end

RSpec.configure do |c|
  c.include ListHelpers
end
