class MapController < ApplicationController
  before_action :require_login
  
  def show
    @games = Game.within_date_end.to_a
  end
end
