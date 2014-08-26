class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.belongs_to :order
      t.belongs_to :item
    end
  end
end
