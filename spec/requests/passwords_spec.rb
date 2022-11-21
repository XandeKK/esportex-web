require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "GET #new" do
    it "renders new password" do
      get new_password_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create a deliver email to reset password" do
      user = create(:user)
      get passwords_path, params: {
        email: user.email
      }

      expect(response).to have_http_status(:found)
    end

    it "not create a deliver email to reset password" do
      user = create(:user)
      get passwords_path, params: {
        email: ""
      }

      expect(response).to have_http_status(:found)
    end
  end

  # Eu não sei como tester o edit e update
end
