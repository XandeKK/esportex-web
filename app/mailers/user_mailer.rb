class UserMailer < ApplicationMailer
	def forgot_password
	  @user = params[:user]
	  @greeting = "Hi"
	  
	  mail to: @user.email, :subject => 'Reset password instructions'
	end
end
