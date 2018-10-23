class AthletesController < ApplicationController
  before_action :set_athlete, only: [:show, :graph]
  before_action :set_pb, only: [:show]
  
  def index
    @athletes = Athlete.order('active desc, grade asc, id desc').page(params[:page]).per(30)
  end

  def show
  end

  def graph
    redirect_to athlete_path(@athlete) if set_result.nil? || @results.size.zero?
    gon.dates = @dates
    gon.results = @results
    gon.max = @max
    gon.min = @min
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

  def set_result
    @competition = params[:competition]
    @type = params[:type]
    return nil unless @competition
    case @type
    when 'short'
      results = ShortResult.where(athlete_id: @athlete.id, competition: @competition, official: true).where.not(result: nil).order('established_date asc')
    when 'long'
      results = LongResult.where(athlete_id: @athlete.id, competition: @competition, official: true).where.not(result: nil).order('established_date asc')
    when 'field'
      results = FieldResult.where(athlete_id: @athlete.id, competition: @competition, official: true).where.not(result: nil).order('established_date asc')
    else
      return nil
    end

    @min = ['short', 'long'].include?(@type) ? results.minimum(:result).to_f/ 1000 : results.minimum(:result)
    @max = ['short', 'long'].include?(@type) ? results.maximum(:result).to_f/ 1000 : results.maximum(:result)
    @years = results.pluck(:established_date).map(&:year).uniq
    results = results.where(established_date: Date.new(params[:year].to_i)...Date.new(params[:year].to_i, 12, 31)) if params[:year].present?

    @dates = results.pluck(:established_date).map(&:to_s)
    @results = results.pluck(:result).map { |r| ['short', 'long'].include?(params[:type]) ? (r.to_f / 1000).to_s : r.to_s }
  end
end
