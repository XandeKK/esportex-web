class SportController < ApplicationController
  before_action :require_login
  
  def index
    @sports = Sport.all
  end
end
