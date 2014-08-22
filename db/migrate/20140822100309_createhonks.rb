class Createhonks < ActiveRecord::Migration
  def change
    create_table :honks do |h|
      h.belongs_to :user
      h.string :content
    end
  end
end
