class ProfileController < ApplicationController
  before_action :require_login
  
  def show
    @user = User.find_by_username(params[:profile])

    if @user.nil?
      redirect_to root_path, alert: "User don't exist"
    end
  end

  def edit
    @user = User.find_by_id(Current.user[:id])
    if @user.nil?
      redirect_to root_path, alert: "What the hell are you trying to do?"
    end
  end

  def update
    @user = User.find_by_id(Current.user[:id])

    if @user.update(user_params)
      redirect_to profile_path(@user.username), notice: "Successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by_id(Current.user[:id])

    if @user.destroy
      redirect_to login_path, notice: "Successfully deleted"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :bio, :avatar)
  end

end
