class UsersController < Clearance::UsersController
	private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)
    username = user_params.delete(:username)
    bio = user_params.delete(:bio)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
      user.username = username
      user.bio = bio
    end
  end
end
