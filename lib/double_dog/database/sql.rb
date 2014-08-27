require 'active_record'

module DoubleDog
  module Database
    class SQL

      class Item < ActiveRecord::Base
        has_many :orderitems
        has_many :orders, :through => :orderitems
        validates_uniqueness_of :name
      end

      class Orderitem < ActiveRecord::Base
        belongs_to :item
        belongs_to :order
      end

      class Order < ActiveRecord::Base
        has_many :orderitems
        has_many :items, :through => :orderitems
        belongs_to :user
      end

      class User < ActiveRecord::Base
        has_many :orders
        validates_uniqueness_of :username
      end

      def create_user(attrs)
        user = get_user_by_username(attrs[:username])
        if user.nil?
          ar_user = User.new
          ar_user.username = attrs[:username]
          ar_user.password = attrs[:password]
          ar_user.admin = attrs[:admin]
          ar_user.save
          DoubleDog::User.new(ar_user.id, ar_user.username, ar_user.password, ar_user.admin)
        else
          return user
        end
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
        item = get_item_by_name(attrs[:name])
        if item.nil?
          ar_item = Item.new
          ar_item.name = attrs[:name]
          ar_item.price = attrs[:price]
          ar_item.save
        else
          ar_item = item
        end
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def get_item(id)
        ar_item = Item.find(id)
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def get_item_by_name(name)
        ar_item = Item.find_by name: name
        return nil if ar_item.nil?
        DoubleDog::Item.new(ar_item.id, ar_item.name, ar_item.price)
      end

      def all_items
        all_items = []
        Item.all.each do |x|
          all_items << DoubleDog::Item.new(x.id, x.name, x.price)
        end
        all_items
      end

      def create_order(attrs)
        ar_order = Order.create(user_id: attrs[:employee_id])
        items = attrs[:items].map do |item|
          Orderitem.create(
            order_id: ar_order.id,
            item_id: item.id
          )
          # o.order_id = ar_order.id
          # o.item_id = i
          # o.save
          q = DoubleDog::Item.new(item.id, item.name, item.price)
          # items << q
        end
        build_order(ar_order)
      end

      def get_order(id)
        ar_order = Order.find(id)
        ar_order_items = Item.joins(:orderitems).where(orderitems: {order_id: id})
        items = []
        ar_order_items.each do |x|
          items << DoubleDog::Item.new(id, x.name, x.price)
        end
        # DoubleDog::Order.new(ar_order.id, ar_order.user_id, items)        
        build_order(ar_order)
      end

      def all_orders
        all_orders = []
        Order.find_each do |x|
          y = get_order(x.id)
          all_orders << y
        end
        all_orders
      end

    private

      def build_order(ar_order)
        DoubleDog::Order.new(ar_order.id, ar_order.user_id, items)
      end

    end
  end
end