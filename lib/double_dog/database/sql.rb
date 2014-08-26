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
        ar_user = User.new
        ar_user.username = attrs[:username]
        ar_user.password = attrs[:password]
        ar_user.admin = attrs[:admin]
        ar_user.save
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def get_user(id)
        ar_user = User.find(id)
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
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
        ar_user = User.find_by username: username
        return nil if ar_user.nil?
        DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
      end

      def create_item(attrs)
        ar_item = Item.new
        ar_item.name = attrs[:name]
        ar_item.price = attrs[:price]
        ar_item.save
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def get_item(id)
        ar_item = Item.find(id)
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def all_items
        # @items.values.map do |attrs|
        #   Item.new(attrs[:id], attrs[:name], attrs[:price])
        # end
      end

      def create_order(attrs)
        ar_order = Order.new
        ar_order.user_id = attrs[:employee_id]
        ar_order.save
        ar_order_items = Item.where order_id: ar_order.id
        DoubleDog::Order.new(ar_order.id, ar_order.user_id, ar_order_items)
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