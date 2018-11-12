class SearchController < ApplicationController
  before_action :set_sort_options
  def index
    @short_results = search_result('ShortResult')
    @long_results = search_result('LongResult')
    @field_results = search_result('FieldResult')
    @relay_results = search_result('RelayResult')
    @decathlon_results = search_result('DecathlonResult')
  end

  private
  
  def search_result(class_name)
    if class_name == 'RelayResult'
      if params[:athlete_id].present?
        result = RelayResult.where(first_athlete_id: params[:athlete_id]).or(
                   RelayResult.where(second_athlete_id: params[:athlete_id])).or(
                     RelayResult.where(third_athlete_id: params[:athlete_id])).or(
                       RelayResult.where(fourth_athlete_id: params[:athlete_id]))
      end
    else
      result = Object.const_get(class_name).where(athlete_id: params[:athlete_id]) if params[:athlete_id].present?
    end
   
    if params[:established_from].present? || params[:established_to].present?
      from = Date.new(params[:established_from].present? ? params[:established_from].to_i : 1995, 1, 1)
      to = Date.new(params[:established_to].present? ? params[:established_to].to_i : Time.zone.today.year, 12, 31)
      if result.nil?
        result = Object.const_get(class_name).where(established_date: from..to)
      else
        result = result.where(established_date: from..to)
      end
    end

    if params[:competition].present?
      if result.nil?
        if class_name == 'DecathlonResult'
          result = DecathlonResult.all
        else
          result = Object.const_get(class_name).where(competition: params[:competition])
        end
      else
        result = result.where(competition: params[:competition]) unless class_name == 'DecathlonResult'
      end
    end
    result = result.where(official: true).where.not(result: nil) if result.present? && params[:official]
    result = result.limit(params[:num].to_i) if params[:num].present?
    result
  end

  def set_sort_options
    @sort_options = [['樹立日 新しい順', 'established_date desc'],
                     ['樹立日 古い順', 'established_date asc'],
                     ['記録 降順', 'result desc'],
                     ['記録 昇順', 'result asc']
    ]
  end
end
