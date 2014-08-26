require 'active_record'
require 'active_record_tasks'
require_relative '../lib/double_dog.rb'

if ENV['APP_ENV'] == 'development'
else
  DoubleDog.db = DoubleDog::Database::InMemory.new
  # ActiveRecord::Base.establish_connection(
  #   :adapter => 'postgresql',
  #   :database => 'doubledog_test'
  # )
end

  DoubleDog.db = DoubleDog::Database::SQL.new
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'doubledog_dev'
  )
