require 'spec_helper'

describe DoubleDog::CreateAccount do
  let(:script) {DoubleDog::CreateAccount}
  let(:successful_login) do 
    expect(script).to receive(:admin_session?).and_return(true)
  end
  let(:unsuccessful_login) do
    expect(script).to receive(:admin_session?).and_return(false)
  end

  describe 'Validation' do
    it "requires the creator to be an admin" do
      unsuccessful_login = script.run(:session_id => 'nope', :username => 'a', :password => 'b')
      expect(unsuccessful_login[:success?]).to eq false
      expect(unsuccessful_login[:error]).to eq :not_admin
    end

    it "requires a username" do
      script = DoubleDog::CreateAccount
      expect(script).to receive(:admin_session?).and_return(true)

      result = script.run(:session_id => 0, :password => 'bluh')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_username
    end

    it "requires a username to be at least three characters" do
      script = DoubleDog::CreateAccount
      expect(script).to receive(:admin_session?).and_return(true)

      result = script.run(:session_id => 0, :username => 'ab', :password => 'bluh')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_username
    end

    it "requires a password" do
      script = DoubleDog::CreateAccount
      expect(script).to receive(:admin_session?).and_return(true)

      result = script.run(:session_id => 0, :username => 'bob')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_password
    end

    it "requires a password with at least three characters" do
      script = DoubleDog::CreateAccount
      expect(script).to receive(:admin_session?).and_return(true)

      result = script.run(:session_id => 0, :username => 'bob', :password => '12')
      expect(result[:success?]).to eq false
      expect(result[:error]).to eq :invalid_password
    end
  end

  it "creates an account" do
    script = DoubleDog::CreateAccount
    expect(script).to receive(:admin_session?).and_return(true)

    result = script.run(:session_id => 0, :username => 'bob', :password => 'letmein')
    expect(result[:success?]).to eq true

    user = result[:user]
    expect(user.id).to_not be_nil
    expect(user.username).to eq 'bob'
    expect(user.has_password? 'letmein').to eq true
  end

end
