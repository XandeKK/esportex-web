class ApplicationController < ActionController::Base
	private

  	def require_login
	  	user = User.find_by(id: session[:user_id])
	    if user.nil?
	    	redirect_to login_path
	    else
	    	set_current_user user
	    end
	end

  	def set_current_user(user)
		Current.user = user
	end
end
