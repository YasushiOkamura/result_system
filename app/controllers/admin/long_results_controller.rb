# frozen_string_literal: true

class Admin::LongResultsController < Admin::BaseController
  before_action :set_long_result, only: %i[edit update destroy]
  before_action :long_competition_options, only: %i[new edit create update edit destroy]

  def index
    @q = LongResult.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @long_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @long_result = LongResult.new(official: true)
  end

  def edit; end

  def create
    @long_result = LongResult.new(long_result_params)
    if @long_result.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_long_result_path(@long_result)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @long_result.update(long_result_params)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_long_result_path(@long_result)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @long_result.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_long_results_path, notice: '削除しました'
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_long_results_path(@long_result), error: '削除に失敗しました'
    end
  end

  private

  def set_long_result
    @long_result = LongResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def long_result_params
    params[:long_result][:result] = result_parse(params[:long_result][:result])
    params.require(:long_result).permit(
      :competition,
      :result,
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

  def long_competition_options
    @competition_options = []
    Competition.where(kind: :long).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end
end
