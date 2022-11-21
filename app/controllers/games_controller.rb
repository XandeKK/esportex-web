class GamesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_sport, except: [:new, :create]
  before_action :redirect_invalid_sport, except: [:new, :create]
  before_action :set_game, except: [:index, :new, :create, :show]
  before_action :redirect_invalid_game, except: [:index, :new, :create, :show]

  def index
    # Não sei como que eu vou coletar informações necessárias.
    # @games = Game.
    #   where("sport_id = ?", params[:sport]).
    #   where("start_date::date <= ?::date OR (start_date::date >= ?::date AND end_date::date <= ?::date)", params[:current_time],
    #     params[:current_time], params[:current_time]).
    #   near([params[:lat], params[:lon]], 10, units: :km)
  end

  def show
    @game = Game.find_by(id: params[:id])
    redirect_invalid_game
  end

  def new
  end

  def create
    @game = current_user.games.new(game_params)

    if @game.save
      redirect_to game_path(sport: @game.sport_id, id: @game.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(sport: @game.sport_id, id: @game.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @game.destroy
      redirect_to sports_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:sport_id, :title, :start_date, :end_date, :address, :info)
  end

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
