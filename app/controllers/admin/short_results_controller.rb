# frozen_string_literal: true

class Admin::ShortResultsController < Admin::BaseController
  before_action :set_short_result, only: %i[edit update destroy]
  before_action :short_competition_options, only: %i[new edit create update edit destroy]

  def index
    @q = ShortResult.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @short_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @short_result = ShortResult.new(official: true)
  end

  def edit; end

  def create
    @short_result = ShortResult.new(short_result_params)
    if @short_result.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_short_result_path(@short_result)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @short_result.update(short_result_params)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_short_result_path(@short_result)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @short_result.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_short_results_path
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_short_results_path(@short_result)
    end
  end

  private

  def set_short_result
    @short_result = ShortResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def short_result_params
    params[:short_result][:result] = result_parse(params[:short_result][:result])
    params.require(:short_result).permit(
      :competition_id,
      :result,
      :wind,
      :round,
      :group,
      :rane,
      :finish,
      :athlete_id,
      :tournament_id,
      :grade,
      :established_date,
      :information,
      :condition,
      :official
    )
  end

  def short_competition_options
    @competition_options =
      Competition.where(kind: :short).order(:position).each_with_object([]) do |competition, arr|
        arr << [competition.name, competition.id]
      end
  end
end
