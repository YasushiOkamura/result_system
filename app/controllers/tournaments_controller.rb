class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show]
  
  def index
    @tournaments = Tournament.page(params[:page])
  end

  def show
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
