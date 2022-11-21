require 'rails_helper'

RSpec.describe "Games", type: :request do
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

  describe "GET #index" do
    it "renders index game page" do
      sport = create(:sport)
      get games_path(sport: sport.id)
      expect(response).to have_http_status(:success)
    end

    it "redirects when there is no sport" do
      get games_path(sport: "sport_stupid")
      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #show" do
    it "renders show game" do
      sport = create(:sport)
      game = create(:game)
      get game_path(sport: sport.id, id: game.id)
      expect(response).to have_http_status(:success)
    end

    it "redirects when there is no game" do
      sport = create(:sport)
      get game_path(sport: sport.id, id: "game_stupid")
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #new" do
    it "renders new game" do
      sign_in
      get new_game_path
      expect(response).to have_http_status(:success)
    end

    it "redirects when not logged in" do
      get new_game_path "/sports/games/new"
      expect(response).to redirect_to("/sign_in")
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #create" do
    it "create a game" do
      sign_in
      expect do
        post create_game_path, params: {
          game: {
            sport_id: create(:sport).id,
            title: "Vamos jogar",
            start_date: 5.hours.ago,
            end_date: 1.hours.after,
            address: "Lagarto",
            info: "Qualquer trouxa pode jogar"
          }
        }
      end.to change{ Game.count }

      expect(response).to have_http_status(:found)
    end

    it "not create a game without params" do
      sign_in
      expect { post create_game_path }.to raise_error(ActionController::ParameterMissing)
    end

    it "not create a game without without attributes" do
      sign_in
      expect do
        post create_game_path, params: {
          game: {
            sport_id: '',
            title: '',
            start_date: '',
            end_date: '',
            address: '',
            info: ''
          }
        }
      end.to_not change{ Game.count }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      user = sign_in
      sport = create(:sport)
      game = create(:game, user: user)
      get edit_game_path(sport:sport.id, id: game.id)
      expect(response).to have_http_status(:success)
    end

    it "redirects when not allowed" do
      sign_in
      sport = create(:sport)
      game = create(:game)
      get edit_game_path(sport:sport.id, id: game.id)
      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end
  end

  describe "PUT #update" do
    it "update a game" do
      user = sign_in
      sport = create(:sport)
      game = create(:game, user: user)

      put game_path(sport: sport.id, id: game.id), params: {
        game: {
          sport: create(:sport).id,
          title: "Vapo",
          start_date: 5.hours.ago,
          end_date: 1.hours.after,
          address: "Lagarto",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to redirect_to(game_path(sport: game.sport_id, id: game.id))
      expect(response).to have_http_status(:found)
    end

    it "not update a game without invalid attributes" do
      user = sign_in
      sport = create(:sport)
      game = create(:game, user: user)
      
      put game_path(sport: sport.id, id: game.id), params: {
        game: {
          sport: '',
          title: '',
          start_date: '',
          end_date: '',
          address: '',
          info: ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "not update when not allowed" do
      sign_in
      sport = create(:sport)
      game = create(:game)

      put "/sports/#{sport.id}/games/#{game.id}", params: {
        game: {
          sport: create(:sport).id,
          title: "Vamos jogar",
          start_date: 5.hours.ago,
          end_date: 1.hours.after,
          address: "Lagarto",
          info: "Qualquer trouxa pode jogar"
        }
      }

      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE #delete" do
    it "destroy a game" do
      user = sign_in
      sport = create(:sport)
      game = create(:game, user: user)

      expect do 
        delete game_path(sport: sport.id, id: game.id)
      end.to change{ Game.count }

      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end

    it "not destroy a game when not allowed" do
      sign_in
      sport = create(:sport)
      game = create(:game)

      delete "/sports/#{sport.id}/games/#{game.id}"

      expect(response).to redirect_to("/sports")
      expect(response).to have_http_status(:found)
    end
  end

end
