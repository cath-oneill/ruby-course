module Honkr
  class Honk

    attr_reader :id, :user_id, :content

    def initialize(id, user_id, content)
      @id = id
      @user_id = user_id
      @content = content
    end

    def set_id(new_id)
      @id = new_id
    end
  end
end
