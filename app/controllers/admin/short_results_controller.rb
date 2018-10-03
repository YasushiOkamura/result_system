class Admin::ShortResultsController < Admin::BaseController
  before_action :set_short_result, only: [:edit, :update, :destroy]
  before_action :short_competition_options, only: [:new, :edit, :create, :update, :edit, :destroy]

  def index
    @q = ShortResult.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @short_results = @q.result(distinct: true).page(params[:page])
  end

  def new
    @short_result = ShortResult.new
  end

  def edit
  end

  def create
    @short_result = ShortResult.new(short_result_params)
    if @short_result.save
      flash.now[:notice] = '新規作成しました'
      redirect_to edit_admin_short_result_path(@short_result)
    else
      flash.now[:notice] = '新規作成に失敗しました'
      render :new, error: '結果の作成に失敗しました'
    end
  end

  def update
    if @short_result.update(short_result_params)
      flash.now[:notice] = '更新しました'
      redirect_to edit_admin_short_result_path(@short_result)
    else
      flash.now[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @short_result.destroy
      flash.now[:notice] = '削除しました'
      redirect_to admin_short_results_path
    else
      flash.now[:notice] = '削除に失敗しました'
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
      :condition
    )
  end

  def short_competition_options
    @competition_options = []
    Competition.where(kind: :short).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end

end
