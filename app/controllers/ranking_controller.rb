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
        @all_results << FieldResult.includes(:athlete, :tournament).joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.max_by(&:result) }.sort_by(&:result).reverse.take(5)
      when 'short'
        @all_results << ShortResult.includes(:athlete, :tournament).joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.min_by(&:result) }.sort_by(&:result).take(5)
      when 'long'
        @all_results << LongResult.includes(:athlete, :tournament).joins(:athlete).where(competition: competition.name, official: true).where.not(result: nil).group_by(&:athlete_id).map { |_id, s| s.min_by(&:result) }.sort_by(&:result).take(5)
      when 'relay'
        @all_results << RelayResult.includes(:tournament, :first_athlete, :second_athlete, :third_athlete, :fourth_athlete).where(competition: competition.name, official: true).where.not(result: nil).order('result').limit(10)
      when 'decathlon'
        @all_results << DecathlonResult.includes(decathlon_includes_list).joins(:athlete).where(official: true).where.not(total_score: nil).group_by(&:athlete_id).map { |_id, s| s.max_by(&:total_score) }.sort_by(&:total_score).reverse.take(5)
      end
    end
  end

  def decathlon_includes_list
    [:athlete, :tournament, :short_100m_result, :field_lj_result, :field_sp_result, :field_hj_result, :short_400m_result, :short_110mh_result, :field_dt_result, :field_pj_result, :field_jt_result, :long_1500m_result]
  end
end
