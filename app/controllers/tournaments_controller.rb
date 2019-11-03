# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show]

  def index
    @tournaments = Tournament.order('start_day desc').page(params[:page])
  end

  def show
    @short_results = @tournament.short_results.includes(:athlete).order('competition desc, result asc')
    @long_results = @tournament.long_results.includes(:athlete).order('competition desc, result asc')
    @field_results = @tournament.field_results.includes(:athlete).order('competition desc, result desc')
    @relay_results = @tournament.relay_results.order('competition desc, result asc')
    @decathlon_results = @tournament.decathlon_results.includes(:athlete).order('total_score desc')
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
