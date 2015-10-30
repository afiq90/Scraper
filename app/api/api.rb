class API < Grape::API

	# before do
	# 	error!("401 Unauthorized, 401", 401) unless authenticated
	# end

	 # http_basic do |email, password|
		# user = User.find_by_email(email)
		# user && user.valid_password?(password)
	 # end

	prefix 'api'
	version 'v1', using: :path
	format :json

	rescue_from :all, backtrace: true
	error_formatter :json, ErrorFormatter

	helpers do
		def authenticate!
			error!("Unauthorized. Invalid or expired token.", 401) unless current_user
		end

		def current_user
			# find token, Check if valid
			token = ApiKey.where(access_token: params[:token]).first
			if token && !token.expired?
				@current_user = User.find(token.user_id)
			else
				false
			end
		end
	end

	# Mount all authenticated APIs here
	mount Articles::ArticleData
	mount Movies::MovieData
	mount Auth::Authorization
	
end