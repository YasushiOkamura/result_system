# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tournaments = Tournament.order('start_day desc').take(5)
    @tournament_ids = ShortResult.where(tournament_id: @tournaments.map(&:id)).pluck(:tournament_id)
    @tournament_ids += LongResult.where(tournament_id: @tournaments.map(&:id)).pluck(:tournament_id)
    @tournament_ids += FieldResult.where(tournament_id: @tournaments.map(&:id)).pluck(:tournament_id)
    @tournament_ids += RelayResult.where(tournament_id: @tournaments.map(&:id)).pluck(:tournament_id)
    @tournament_ids += DecathlonResult.where(tournament_id: @tournaments.map(&:id)).pluck(:tournament_id)
  end
end
