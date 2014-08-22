require 'active_record'

module Honkr
  module Databases
    class SQL

      class User < ActiveRecord::Base
        has_many :honks
      end

      class Honk < ActiveRecord::Base
        belongs_to :User
      end

      ##Nick used instance_variable_set (instead of setter method)
      #which may be OK in this 
      #situation.  Although depending on who you ask, 
      #the setter method may be OK.
      def persist_honk(honk)
          ar_honk = Honk.new #don't need full namespacing because we are within SQL class
          ar_honk.user_id = honk.user_id
          ar_honk.content = honk.content
          ar_honk.save
          honk.set_id(ar_honk.id)
          #honk.instance_variable_set :id, ar_honk.id
      end

      def get_honk(id)
        ar_honk = Honk.find(id)
        #test passes without next line, but can't use methods
        Honkr::Honk.new(ar_honk.id,
                        ar_honk.user_id,
                        ar_honk.content)
      end

      def persist_user(user)
          ar_user = User.new
          ar_user.username = user.username
          ar_user.password_digest = user.password_digest
          ar_user.save
          user.set_id(ar_user.id)
      end

      def get_user(id)
        ar_user = User.find(id)
        Honkr::User.new(ar_user.id,
                        ar_user.username,
                        ar_user.password_digest)
      end

    end
  end
end
