require 'active_record'

if ENV['APP_ENV'] == 'development'
  DoubleDog.db = DoubleDog::Database::SQL.new
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'doubledog_dev'
  )
  
else
  DoubleDog.db = DoubleDog::Database::InMemory.new
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'doubledog_test'
  )
end

