module DoubleDog
  class SeeAllOrders
    extend Failure_Success
    extend Admin_Session
    
    def self.run(params)
      return failure(:not_admin) unless admin_session?(params[:admin_session])

      orders = DoubleDog.db.all_orders
      return success(orders: orders)
    end


  end
end