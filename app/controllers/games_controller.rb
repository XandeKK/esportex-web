class GamesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_sport, except: [:new, :create]
  before_action :redirect_invalid_sport, except: [:new, :create]
  before_action :set_game, except: [:index, :new, :create]
  before_action :redirect_invalid_game, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def set_sport
    @sport = Sport.find_by(id: params[:sport])
  end

  def redirect_invalid_sport
    redirect_to sports_path, alert: "Invalid sport: #{params[:sport]}" unless @sport
  end

  def set_game
    @game = current_user.games.find_by(id: params[:id])
  end

  def redirect_invalid_game
    redirect_to sports_path, alert: "Error" unless @game
  end
end
