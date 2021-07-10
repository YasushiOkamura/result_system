# frozen_string_literal: true

class Admin::RoadResultsController < Admin::BaseController
  before_action :set_road_result, only: %i[edit update destroy]
  before_action :road_competition_options, only: %i[new edit create update edit destroy]

  def index
    @q = RoadResult.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
    @road_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @road_result = RoadResult.new(official: true)
  end

  def edit
  end

  def create
    @road_result = RoadResult.new(road_result_params)
    if @road_result.save
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_road_result_path(@road_result)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def update
    if @road_result.update(road_result_params)
      flash[:notice] = "更新しました"
      redirect_to edit_admin_road_result_path(@road_result)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @road_result.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_road_results_path, notice: "削除しました"
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to edit_admin_road_results_path(@road_result), error: "削除に失敗しました"
    end
  end

  private

    def set_road_result
      @road_result = RoadResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def road_result_params
      params[:road_result][:result] = result_parse(params[:road_result][:result])
      params.require(:road_result).permit(
        :competition_id,
        :result,
        :round,
        :finish,
        :athlete_id,
        :tournament_id,
        :grade,
        :established_date,
        :information,
        :condition,
        :official,
      )
    end

    def road_competition_options
      @competition_options =
        Competition.where(kind: :road).order(:position).each_with_object([]) do |competition, arr|
          arr << [competition.name, competition.id]
        end
    end
end
