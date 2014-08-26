require 'active_record'

module DoubleDog
  module Database
    class SQL

      class Item < ActiveRecord::Base
        belongs_to :order
      end

      class Order < ActiveRecord::Base
        has_many :items
        belongs_to :user
      end

      class User < ActiveRecord::Base
        has_many :orders
      end

      def create_user(attrs)
        # new_id = (@item_id_counter += 1)
        # @users[new_id] = attrs
        # attrs[:id] = new_id
        # User.new(attrs[:id], attrs[:username], attrs[:password], attrs[:admin])
      end

      def get_user(id)
        # attrs = @users[id]
        # User.new(attrs[:id], attrs[:username], attrs[:password], attrs[:admin])
      end

      def create_session(attrs)
        # new_id = (@sessions_id_counter += 1)
        # @sessions[new_id] = attrs
        # return new_id
      end

      def get_user_by_session_id(sid)
        # return nil if @sessions[sid].nil?
        # user_id = @sessions[sid][:user_id]
        # user_attrs = @users[user_id]
        # User.new(user_attrs[:id], user_attrs[:username], user_attrs[:password], user_attrs[:admin])
      end

      def get_user_by_username(username)
        # user_attrs = @users.values.find { |attrs| attrs[:username] == username }
        # return nil if user_attrs.nil?
        # User.new(user_attrs[:id], user_attrs[:username], user_attrs[:password], user_attrs[:admin])
      end

      def create_item(attrs)
        # new_id = (@item_id_counter += 1)
        # @items[new_id] = attrs
        # attrs[:id] = new_id
        # Item.new(attrs[:id], attrs[:name], attrs[:price])
      end

      def get_item(id)
        # attrs = @items[id]
        # Item.new(attrs[:id], attrs[:name], attrs[:price])
      end

      def all_items
        # @items.values.map do |attrs|
        #   Item.new(attrs[:id], attrs[:name], attrs[:price])
        # end
      end

      def create_order(attrs)
        # new_id = (@order_id_counter += 1)
        # @orders[new_id] = attrs
        # attrs[:id] = new_id
        # Order.new(attrs[:id], attrs[:employee_id], attrs[:items])
      end

      def get_order(id)
        # attrs = @orders[id]
        # Order.new(attrs[:id], attrs[:employee_id], attrs[:items])
      end

      def all_orders
        # @orders.values.map do |attrs|
        #   Order.new(attrs[:id], attrs[:employee_id], attrs[:items])
        # end
      end

    end
  end
end