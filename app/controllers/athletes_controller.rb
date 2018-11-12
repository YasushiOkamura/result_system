class AthletesController < ApplicationController
  before_action :set_athlete, only: [:show, :graph]
  before_action :set_pb, only: [:show]
  BLUE = 'rgba(75, 192, 192, 1)'
  RED = 'rgba(255, 100, 100, 1)'

  def index
    @athletes = Athlete.order('active desc, grade asc, id desc').page(params[:page]).per(30)
  end

  def show
  end

  def graph
    redirect_to athlete_path(@athlete) if set_result.nil? || gon.results.size.zero?
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
    @pb[:decathlon] = DecathlonResult.where(athlete_id: @athlete.id, official: true).where.not(total_score: nil).order('total_score desc').first
  end

  def set_result
    @competition = params[:competition]
    @type = params[:type]
    return nil unless @competition
    case @type
    when 'short'
      results = ShortResult.where(athlete_id: @athlete.id, competition: @competition).where.not(result: nil).order('established_date asc')
    when 'long'
      results = LongResult.where(athlete_id: @athlete.id, competition: @competition).where.not(result: nil).order('established_date asc')
    when 'field'
      results = FieldResult.where(athlete_id: @athlete.id, competition: @competition).where.not(result: nil).order('established_date asc')
    else
      return nil
    end
    
    @years = results.pluck(:established_date).map(&:year).uniq
    gon.min = ['short', 'long'].include?(@type) ? results.minimum(:result).to_f/ 1000 : results.minimum(:result)
    gon.max = ['short', 'long'].include?(@type) ? results.maximum(:result).to_f/ 1000 : results.maximum(:result)
    results = results.where(established_date: Date.new(params[:year].to_i)...Date.new(params[:year].to_i, 12, 31)) if params[:year].present?
    
    result_data = results.pluck(:official, :tournament_id, :established_date, :result, :wind) if ['short', 'field'].include?(@type)
    result_data = results.pluck(:official, :tournament_id, :established_date, :result) if ['long'].include?(@type)
    gon.colors = result_data.map { |r| r[0] ? BLUE : RED }
    gon.tournaments = []
    results.each do |result|
      gon.tournaments << result.tournament.name
    end

    gon.dates = result_data.map { |r| r[2].to_s }
    gon.results = result_data.map { |r| ['short', 'long'].include?(@type) ? (r[3].to_f / 1000).to_s : r[3].to_s }
    gon.winds = ['short', 'field'].include?(@type) ? result_data.map { |r| r[4].present? ? "(#{r[4] >= 0.0 ? '+' : ''}#{r[4]})" : "" } :  Array.new(results.size, "")
  end
end
