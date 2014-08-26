require 'active_record'
require 'active_record_tasks'
require_relative '../lib/double_dog.rb'

if ENV['APP_ENV'] == 'development'
  DoubleDog.db = DoubleDog::Databases::SQL.new
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'doubledog_dev'
  )
else
  DoubleDog.db = DoubleDog::Databases::InMemory.new
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'doubledog_test'
  )
end
