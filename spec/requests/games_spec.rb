require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET #index" do
    it "renders index game page" do
      sport = create(:sport)
      get "/sports/#{sport.id}/games"
      expect(response).to have_http_status(:success)
    end

    it "redirects when there is no sport" do
      get "/sports/sport_stupid/games"
      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #show" do
    it "renders show game" do
      sign_in
      sport = create(:sport)
      game = create(:game)
      get "/sports/#{sport.id}/games/#{game.id}"
      expect(response).to have_http_status(:success)
    end

    it "redirects when there is no game" do
      sport = create(:sport)
      get "/sports/#{sport.id}/games/game_stupid"
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "GET #new" do
    it "renders new game" do
      get "/sports/games/new"
      expect(response).to have_http_status(:success)
    end

    it "redirects when not logged in" do
      get "/sports/games/new"
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "POST #create" do
    it "create a game" do
      post "/sports/games", params: {
        game: {
          sport: create(:sport).id,
          title: "Vamos jogar",
          start_date: 5.hours.ago,
          end_date: 1.hours.after,
          address: "Lá na puta que pariu",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to have_http_status(:moved_permanently)
    end

    it "not create a game without invalid attributes" do
      post "/sports/games"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sport = create(:sport)
      game = create(:game)
      get "/sports/#{sport.id}/games/#{game.id}/edit"
      expect(response).to have_http_status(:success)
    end

    it "redirects when not allowed" do
      sport = create(:sport)
      game = create(:game)
      get "/sports/#{sport.id}/games/#{game.id}/edit"
      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "PUT #update" do
    it "update a game" do
      sport = create(:sport)
      game = create(:game)

      put "/sports/#{sport.id}/games/#{game.id}", params: {
        game: {
          sport: create(:sport).id,
          title: "Vamos jogar",
          start_date: 5.hours.ago,
          end_date: 1.hours.after,
          address: "Lá na puta que pariu",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to have_http_status(:moved_permanently)
    end

    it "not update a game without invalid attributes" do
      sport = create(:sport)
      game = create(:game)
      
      put "/sports/#{sport.id}/games/#{game.id}", params: {
        game: {
          sport: create(:sport).id,
          title: "Vamos jogar",
          start_date: 5.hours.after,
          end_date: 1.hours.after,
          address: "Lá na puta que pariu",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "not update when not allowed" do
      sport = create(:sport)
      game = create(:game)

      put "/sports/#{sport.id}/games/#{game.id}", params: {
        game: {
          sport: create(:sport).id,
          title: "Vamos jogar",
          start_date: 5.hours.ago,
          end_date: 1.hours.after,
          address: "Lá na puta que pariu",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "DELETE #delete" do
    it "destroy a game" do
      sport = create(:sport)
      game = create(:game)

      delete "/sports/#{sport.id}/games/#{game.id}"

      expect(response).to redirect_to("/sports/#{sport.id}")
      expect(response).to have_http_status(:moved_permanently)
    end

    it "not destroy a game when not allowed" do
      sport = create(:sport)
      game = create(:game)

      delete "/sports/#{sport.id}/games/#{game.id}"

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

end
