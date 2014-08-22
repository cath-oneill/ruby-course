class Honks < ActiveRecord::Migration
  def change
    create_table :honks do |h|
      h.integer :user_id
      h.string :content
    end
  end
end
