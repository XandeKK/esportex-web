class SessionController < ApplicationController
  def new
  end

  def create
    if params[:login].match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
      user = User.find_by(email: params[:login])&.authenticate(params[:password])
    else
      user = User.find_by(username: params[:login])&.authenticate(params[:password])
    end

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "login successfully"
    else
      flash.now[:alert] = "Email/password is incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    if session[:user_id]
      redirect_to root_path, alert: "Logout failed"
    else
      redirect_to login_path, notice: "Logout successfully"
    end
  end
end
