require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #new" do
    it "renders sign up" do
      get sign_up_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create a user" do
      post users_path, params: {
        user: {
          name: 'Fulano de tal',
          email: 'Nao@gmail.com',
          username: 'foda',
          password: 'foda',
          bio: 'sou foda'
        }
      }

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:found)
    end

    it "not create a user with invalid attributes" do
      post users_path, params: {
        user: {
          name: '',
          email: '',
          username: '',
          password: '',
          bio: ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
