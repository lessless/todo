module Lists
  class Create
    def initialize(user)
      @user = user
    end

    def execute!(params)
      List.create!(author: @user)
    end
  end
end
