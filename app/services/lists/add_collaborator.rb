module Lists
  class AddCollaborator
    def initialize(list)
      @list = list
    end

    def execute!(user, action)
      Permission.create!(user: user, list: @list, action: action)
    end
  end
end
