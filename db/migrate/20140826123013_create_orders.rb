class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |o|
      o.belongs_to :user
    end
  end
end
