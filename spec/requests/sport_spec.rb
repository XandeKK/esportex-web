require 'rails_helper'

RSpec.describe "Sports", type: :request do
  describe "GET #index" do
    it "redirects to sports page" do
      get "/sport"
      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:moved_permanently)
    end

    it "returns http success" do
      get "/sports"
      expect(response).to have_http_status(:success)
    end
  end
end
