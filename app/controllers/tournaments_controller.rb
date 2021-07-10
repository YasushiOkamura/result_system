# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show]

  def index
    @tournaments = Tournament.order("start_day desc").page(params[:page])
  end

  def show
    @short_results = ShortResult.includes(:competition).where(tournament_id: @tournament.id).order("competitions.position asc, result asc")
    @long_results = LongResult.includes(:competition).where(tournament_id: @tournament.id).order("competitions.position asc, result asc")
    @field_results = FieldResult.includes(:competition).where(tournament_id: @tournament.id).order("competitions.position asc, result desc")
    @relay_results = RelayResult.includes(:competition).where(tournament_id: @tournament.id).order("competitions.position asc, result asc")
    @road_results = RoadResult.includes(:competition).where(tournament_id: @tournament.id).order("competitions.position asc, result asc")
    @decathlon_results = DecathlonResult.where(tournament_id: @tournament.id).order("total_score desc")
  end

  private

    def set_tournament
      @tournament = Tournament.find(params[:id])
    end
end
