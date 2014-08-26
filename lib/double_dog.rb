require 'pry-byebug'

module DoubleDog
  def self.db
    @__db_instance #||= Database::InMemory.new
  end

  def self.db=(database)
    @__db_instance = database
  end
end


require_relative 'double_dog/database/in_memory.rb'
require_relative 'double_dog/database/sql.rb'

require_relative 'double_dog/entities/item.rb'
require_relative 'double_dog/entities/user.rb'
require_relative 'double_dog/entities/order.rb'

require_relative 'double_dog/scripts/failure_success_mixin.rb'
require_relative 'double_dog/scripts/admin_session_mixin.rb'

require_relative 'double_dog/scripts/create_account.rb'
require_relative 'double_dog/scripts/create_item.rb'
require_relative 'double_dog/scripts/sign_in.rb'
require_relative 'double_dog/scripts/see_all_orders.rb'
require_relative 'double_dog/scripts/create_order.rb'

require_relative '../config/environments.rb'


