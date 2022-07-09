class GameController < ApplicationController
  before_action :require_login

  def index
    if params[:lat].present? && params[:lon].present?
      @games = Game
        .joins(:sport)
        .sport(params[:sport])
        .distance_within_10km( params[:lat], params[:lon] )
        .within_date_end
    else
      @games = Game
        .joins(:sport)
        .sport(params[:sport])
        .within_date_end
    end

    respond_to do |format|
      if @games.present?
        format.html { render partial: 'index', locals: { games: @games, sport: params[:sport] } }
      else
        format.html { render partial: 'blank', locals: { sport: params[:sport] } }
      end
    end
  end

  def show
    @game = Game.find_by_id(params[:id])
  end

  def new
    @game = Game.new
    @sports = Sport.all.to_a.map { |s| [s.name, s.id]}
  end

  def create
    @game = Game.new(game_params)

    @game.user_id = session[:user_id]
    @game.localization = concatenate_lat_lon

    session[:game] = @game

    if @game.save
      redirect_to game_path(@game), notice: "Game created successfully"
    else
      @sports = Sport.all.to_a.map { |s| [s.name, s.id]}
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find_by(id: params[:id], user_id: session[:user_id])
    @sports = Sport.all.to_a.map { |s| [s.name, s.id]}
  end

  def update
    @game = Game.find_by(id: params[:id], user_id: session[:user_id])

    @game.localization = concatenate_lat_lon

    if @game.update(game_params)
      redirect_to game_path(@game), notice: "Game updated successfully"
    else
      @sports = Sport.all.to_a.map { |s| [s.name, s.id]}
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @game = Game.find_by(id: params[:id], user_id: session[:user_id])

    if @game.destroy
      redirect_to root_path, notice: "Game deleted successfully"
    end
  end

  private

  def game_params
    params.require(:game).permit(:sport_id, :info, :start_date, :end_date, :address)
  end

  def concatenate_lat_lon
    "POINT(#{params[:game][:longitude]} #{params[:game][:latitude]})"
  end

end
