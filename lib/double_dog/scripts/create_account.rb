module DoubleDog
  class CreateAccount
    extend Failure_Success
    extend Admin_Session
    
    def self.run(params)
      return failure(:not_admin) unless admin_session?(params[:session_id])
      return failure(:invalid_username) unless valid_username?(params[:username])
      return failure(:invalid_password) unless valid_password?(params[:password])

      user = DoubleDog.db.create_user(:username => params[:username], :password => params[:password])
      return success(:user => user)
    end

    def self.valid_username?(username)
      username != nil && username.length >= 3
    end

    def self.valid_password?(password)
      password != nil && password.length >= 3
    end
  end
end
