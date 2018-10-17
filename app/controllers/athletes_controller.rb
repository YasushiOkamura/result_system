class AthletesController < ApplicationController
  before_action :set_athlete, only: [:show]
  before_action :set_pb, only: [:show]
  
  def index
    @athletes = Athlete.order('active desc, grade asc, id desc').page(params[:page]).per(30)
  end

  def show
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:id])
  end

  def set_pb
    @pb = {}
    @pb[:short] = ShortResult.where(athlete_id: @athlete.id, official: true).where.not(result: nil).group_by(&:competition).map { |competition, results| results.sort_by { |result| result.result }.first }
    @pb[:long] = LongResult.where(athlete_id: @athlete.id, official: true).where.not(result: nil).group_by(&:competition).map { |competition, results| results.sort_by { |result| result.result }.first }
    @pb[:field] = FieldResult.where(athlete_id: @athlete.id, official: true).where.not(result: nil).group_by(&:competition).map { |competition, results| results.sort_by { |result| result.result }.last }
  end
end
