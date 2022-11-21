class ProfilesController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :redirect_not_allowed, except: [:show]

  def show
    @profile = User.find_by(id: params[:id])
  end

  def edit
    @user = current_user
  end
  
  def update
    if current_user.update(user_params)
      redirect_to profile_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :bio)
  end

  def redirect_not_allowed
    redirect_to "/" unless current_user.id == params[:id].to_i
  end
end
