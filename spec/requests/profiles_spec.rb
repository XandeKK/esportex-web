require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  def sign_in
    user = create(:user)
    post session_url, params: {
      session: {
        email: user.email,
        password: 'password'
      }
    }
    user
  end

  describe "GET #show" do
    it "renders show profile" do
      get profile_path(create(:user))
      expect(response).to have_http_status(:success)
    end

    it "redirects if does not exist" do
      get profile_path("not_exist")
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #edit" do
    it "renders edit profile" do
      user = sign_in
      get edit_profile_path(user)
      expect(response).to have_http_status(:success)
    end

    it "redirects when not allowed" do
      sign_in
      get edit_profile_path(create(:user))
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT #update" do
    it "update a user" do
      user = sign_in
      put profile_path(user), params: {
        user: {
          name: "Se fuder",
          email: "Sefuder@gmail.com",
          username: "Sefuder",
          password: "Sefuder",
          bio: "Quero que você se foda"
        }
      }

      expect(response).to redirect_to(profile_path(user))
      expect(response).to have_http_status(:found)
    end

    it "not update a user with invalid attributes" do
      user = sign_in
      put profile_path(user), params: {
        user: {
          name: "",
          email: "",
          username: "",
          password: "",
          bio: ""
        }
      }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "raise ActionController::ParameterMissing" do
      user = sign_in
      expect { put profile_path(user) }.to raise_error(ActionController::ParameterMissing)
    end

    it "redirects when not allowed" do
      sign_in
      put profile_path(create(:user))
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:found)
    end
  end
end

