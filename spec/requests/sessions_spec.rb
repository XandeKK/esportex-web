require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET #new" do
    it "renders sign in" do
      get sign_in_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "sign in" do
      user = create(:user)
      post session_path, params: {
        session: {
          email: user.email,
          password: "password"
        }
      }

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:found)
    end

    it "not sign in without email" do
      post session_path, params: {
        session: {
          email: "",
          password: "password"
        }
      }

      expect(response).to have_http_status(:unauthorized)
    end

    it "not sign in without password" do
      user = create(:user)
      post session_path, params: {
        session: {
          email: user.email,
          password: ""
        }
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE #destroy" do
    it "sign out" do
      user = create(:user)
      post session_path, params: {
        session: {
          email: user.email,
          password: "password"
        }
      }

      delete sign_out_path

      expect(response).to redirect_to(sign_in_path)
      expect(response).to have_http_status(:see_other)
    end

    it "not sign out being logged in" do
      delete sign_out_path

      expect(response).to redirect_to(sign_in_path)
      expect(response).to have_http_status(:see_other)
    end
  end
end
