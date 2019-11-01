# frozen_string_literal: true

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
        @all_results << FieldResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.max_by(&:result) }.sort_by(&:result).reverse.take(5)
      when 'short'
        @all_results << ShortResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.min_by(&:result) }.sort_by(&:result).take(5)
      when 'long'
        @all_results << LongResult.joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.min_by(&:result) }.sort_by(&:result).take(5)
      when 'relay'
        @all_results << RelayResult.where(competition: competition.name, official: true).where.not(result: nil).order('result').limit(10)
      when 'decathlon'
        @all_results << DecathlonResult.joins(:athlete).where(official: true).where.not(total_score: nil).group_by(&:athlete_id).map { |_id, s| s.max_by(&:total_score) }.sort_by(&:total_score).reverse.take(5)
      end
    end
  end
end
