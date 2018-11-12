class RankingController < ApplicationController
  def index
    if params[:kind].nil?
      render :index
    else
      @kind = params[:kind]
      set_results
      if @all_results.empty?
        redirect_to ranking_path
      else
        render :show
      end
    end
  end

  private

  def set_results
    @all_results = []
    Competition.where(kind: @kind).each do |competition|
      case @kind
      when 'field'
        @all_results << FieldResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map {|id, s| s.sort_by{ |a| a.result }.last }.sort_by { |t| t.result }.reverse.take(5)
      when 'short'
        @all_results << ShortResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map {|id, s| s.sort_by{ |a| a.result }.first }.sort_by { |t| t.result }.take(5)
      when 'long'
        @all_results << LongResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map {|id, s| s.sort_by{ |a| a.result }.first }.sort_by { |t| t.result }.take(5)
      when 'relay'
        @all_results << RelayResult.where(competition: competition.name, official: true).where.not(result: nil).order('result').limit(10)
      when 'decathlon'
        @all_results << DecathlonResult.joins(:athlete).where(official: true).where.not(total_score: nil).group_by(&:athlete_id).map {|id, s| s.sort_by { |a| a.total_score }.last }.sort_by { |t| t.total_score }.reverse.take(5)
      else
        nil
      end
    end
  end
end
