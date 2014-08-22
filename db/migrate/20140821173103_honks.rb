##This file is out-of-date
class Honks < ActiveRecord::Migration
  def change
    create_table :honks do |h|
      #this line is wrong, see other file for honks.
      h.integer :user_id
      h.string :content
    end
  end
end
