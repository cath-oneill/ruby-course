class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |i|
      i.string :name
      i.decimal :price
    end
  end
end
