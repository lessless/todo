module Lists
  class Create
    def initialize(user)
      @user = user
    end

    def execute!(params)
      attributes = params.merge({author: @user})
      List.create!(attributes)
    end
  end
end
