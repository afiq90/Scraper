module Auth	
	class Authorization < Grape::API

		resource :authData do

			desc "Creates and returns access_token if valid login"

			params do 
				requires :email, type: String, desc: "Username or email"
				requires :password, type: String, desc: "User pass"
			end

			post do
				user = User.find_by_email(params[:email])

				if user.valid_password?(params[:password])
					key = ApiKey.create(user_id: user.id)
					{token: key.access_token}
				else
					error!("Unauthorized", 401)
				end
			end

			desc "Returns pong if logged in correctly"

			  params do
			    requires :token, type: String, desc: "Access token."
			  end

			  get do
			    authenticate!
			    { message: "pong" }
			  end

		end

	end
end