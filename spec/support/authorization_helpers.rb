module AuthorizationHelpers
  def inject_current_user(controller, user)
    controller.instance_variable_set(:@current_user, user)
    controller.instance_eval { def current_user; @current_user; end }
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
