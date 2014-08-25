require 'spec_helper'
require 'helpers.rb'

describe DoubleDog::SeeAllOrders do
  include Helpers
  let(:script) {DoubleDog::SeeAllOrders}

  describe "Validation" do
    it "requires the user to be an admin" do
      admin(script, false)
      result = script.run(admin_session: 'stubbed')
      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:not_admin)
    end
  end

  it "returns all orders" do
    item_1 = DoubleDog.db.create_item(name: 'hot dog', price: 5)
    item_2 = DoubleDog.db.create_item(name: 'fries', price: 3)
    order_1 = DoubleDog.db.create_order(session_id: 'stubbed', items: [item_1, item_2])
    order_2 = DoubleDog.db.create_order(session_id: 'stubbed', items: [item_2])
    
    admin(script, true)
    result = script.run(admin_session: 'stubbed')
    expect(result[:success?]).to eq(true)

    orders = result[:orders]
    expect(orders.count).to be >= 2
    item_names = orders.map { |order| order.items.map &:name }.flatten
    expect(item_names).to include('hot dog', 'fries')
    expect(item_names.count).to eq(3)
  end
end
