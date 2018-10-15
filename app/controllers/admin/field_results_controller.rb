class Admin::FieldResultsController < Admin::BaseController
  before_action :set_field_result, only: [:edit, :update, :destroy]
  before_action :field_competition_options, only: [:new, :edit, :create, :update, :edit, :destroy]

  def index
    @q = FieldResult.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @field_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @field_result = FieldResult.new
  end

  def edit
  end

  def create
    @field_result = FieldResult.new(field_result_params)
    if @field_result.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_field_result_path(@field_result)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @field_result.update(field_result_params)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_field_result_path(@field_result)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @field_result.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_field_results_path, notice: '削除しました'
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_field_results_path(@field_result), error: '削除に失敗しました'
    end
  end

  private

  def set_field_result
    @field_result = FieldResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def field_result_params
    params.require(:field_result).permit(
      :competition,
      :result,
      :wind,
      :round,
      :finish,
      :athlete_id,
      :tournament_id,
      :grade,
      :established_date,
      :information,
      :condition
    )
  end

  def field_competition_options
    @competition_options = []
    Competition.where(kind: :field).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end

end
