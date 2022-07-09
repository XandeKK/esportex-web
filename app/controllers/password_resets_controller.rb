class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to login_path, notice: 'E-mail sent with password reset instructions'
  end

  def edit
    @user = User.find_by_password_reset_token(params[:token])
    if @user.nil?
      redirect_to login_path, alert: "password reset has expired or don't exist"
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:token])

    if (@user.password_reset_sent_at < 2.hour.ago)
      redirect_to password_resets_path, notice: 'Password reset has expired'
    elsif @user.update(user_params)
      @user.update(password_reset_token: nil)
      redirect_to login_path, notice: 'Password has been reset!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
