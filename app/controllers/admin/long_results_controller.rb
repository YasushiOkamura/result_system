class Admin::LongResultsController < Admin::BaseController
  before_action :set_long_result, only: [:edit, :update, :destroy]
  before_action :long_competition_options, only: [:new, :edit, :create, :update, :edit, :destroy]

  def index
    @long_results = LongResult.page(params[:page])
  end

  def new
    @long_result = LongResult.new
  end

  def edit
  end

  def create
    @long_result = LongResult.new(long_result_params)
    if @long_result.save
      redirect_to edit_admin_long_result_path(@long_result), notice: '結果を作成しました'
    else
      render :new, error: '結果の作成に失敗しました'
    end
  end

  def update
    if @long_result.update(long_result_params)
      redirect_to edit_admin_long_result_path(@long_result)
    else
      render :edit
    end
  end

  def destroy
    if @long_result.destroy
      redirect_to admin_long_results_path, notice: '削除しました'
    else
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
      :condition
    )
  end

  def long_competition_options
    @competition_options = []
    Competition.where(kind: :long).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end
end
