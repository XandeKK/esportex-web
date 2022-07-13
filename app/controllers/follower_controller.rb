class FollowerController < ApplicationController
	before_action :require_login

	def create
		if !Follower.exists?(user_id: Current.user[:id], follower_id: params[:user]) # If not exist
			follower = Follower.new(user_id: Current.user[:id], follower_id: params[:user])
			if follower.save
				# flash[:notice] = "successfully following"
			else
				# flash[:alert] = "Error in following"
			end
		else
			# flash[:alert] = "Must not follow the user who is already following"
		end
		respond_to do |format|
			format.html { render partial: 'button', locals: { user: params[:user] } }
		end
	end

	def destroy
		if Follower.exists?(user_id: Current.user[:id], follower_id: params[:user])
			follower = Follower.find_by(user_id: Current.user[:id], follower_id: params[:user])
			if follower.destroy
				# flash[:notice] = "successfully unfollowing"
			else
				# flash[:alert] = "Error in unfollowing"
			end
		else
			# flash[:alert] = "must not unfollow user who does not follow"
		end
		respond_to do |format|
			format.html { render partial: 'button', locals: { user: params[:user] } }
		end
	end

end
