require 'spec_helper'

describe DoubleDog::CreateItem do
  let(:script) {DoubleDog::CreateItem}

  describe 'Validation' do
    context 'when admin is not signed in' do
      it "requires the user to be an admin" do
        expect_admin(script, false)
        result = script.run(:name => "doesn't matter", :price => 5)
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :not_admin
      end
    end

    context 'when admin is signed in' do
      before :each do
        expect_admin(script, true)
      end

      it "requires a name" do
        result = script.run(:name => nil, :price => 5)
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_name
      end

      it "requires the name to be at least one character" do
        result = script.run(:name => '', :price => 5)
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_name
      end

      it "requires a price" do
        result = script.run(:name => 'x', :price => nil)
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_price
      end

      it "requires a price to be more than fiftey cents" do
        result = script.run(:name => 'y', :price => 0.4)
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_price
      end
    end
  end

  it "creates an item" do
    expect_admin(script, true)
    result = script.run(:name => 'smoothie', :price => 10)
    expect(result[:success?]).to eq true

    item = result[:item]
    expect(item.id).to_not be_nil
    expect(item.name).to eq 'smoothie'
    expect(item.price).to eq 10
  end

end
