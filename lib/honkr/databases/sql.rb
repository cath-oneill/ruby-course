module Honkr
  module Databases
    class SQL

      class User < ActiveRecord::Base
        has_many :honks
      end

      class Honk < ActiveRecord::Base
        belongs_to :User
      end

      def persist_honk(honk)
          ar_honk = Honkr::Databases::SQL::Honk.new
          ar_honk.user_id = honk.user_id
          ar_honk.content = honk.content
          ar_honk.save
          honk.set_id(ar_honk.id)
      end

      def get_honk(id)
        ar_honk = Honkr::Databases::SQL::Honk.find(id)
      end

      def persist_user(user)
          ar_user = Honkr::Databases::SQL::User.new
          ar_user.username = user.username
          ar_user.password_digest = user.password_digest
          ar_user.save
          user.set_id(ar_user.id)
      end

      def get_user(id)
        ar_user = Honkr::Databases::SQL::User.find(id)
      end

    end
  end
end
