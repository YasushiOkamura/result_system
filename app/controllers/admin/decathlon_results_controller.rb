# frozen_string_literal: true

class Admin::DecathlonResultsController < Admin::BaseController
  before_action :set_decathlon_result, only: %i[edit update destroy]

  def index
    @q = DecathlonResult.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
    @decathlon_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @decathlon_result = DecathlonResult.new(official: true)
  end

  def edit
  end

  def create
    @decathlon_result = DecathlonResult.new(create_decathlon_result_params)
    if @decathlon_result.save
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_decathlon_result_path(@decathlon_result)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def update
    if @decathlon_result.update(update_decathlon_result_params)
      flash[:notice] = "更新しました"
      redirect_to edit_admin_decathlon_result_path(@decathlon_result)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @decathlon_result.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_decathlon_results_path
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to edit_admin_decathlon_results_path(@decathlon_result)
    end
  end

  private

    def set_decathlon_result
      @decathlon_result = DecathlonResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_decathlon_result_params
      params.require(:decathlon_result).permit(
        :total_score,
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

    def update_decathlon_result_params
      params.require(:decathlon_result).permit(
        :total_score,
        :finish,
        :athlete_id,
        :tournament_id,
        :grade,
        :established_date,
        :information,
        :condition,
        :official,
        :sprint_100m_id,
        :score_100m,
        :field_lj_id,
        :score_lj,
        :field_sp_id,
        :score_sp,
        :field_hj_id,
        :score_hj,
        :sprint_400m_id,
        :score_400m,
        :sprint_110mh_id,
        :score_110mh,
        :field_dt_id,
        :score_dt,
        :field_pj_id,
        :score_pj,
        :field_jt_id,
        :score_jt,
        :long_1500m_id,
        :score_1500m,
      )
    end
end
