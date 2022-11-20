require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET #index" do
    it "redirects to the home page" do
      get "/"
      expect(response).to redirect_to("/home")
      expect(response).to have_http_status(:moved_permanently)
    end

    it "renders the home page with path home" do
      get "/home"
      expect(response).to have_http_status(:success)
    end
  end
end
