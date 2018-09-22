class Admin::ShortResultsController < Admin::ApplicationController
  before_action :set_short_result, only: [:edit, :update, :destroy]
  before_action :short_competition_options, only: [:new, :edit, :create, :update, :edit, :destroy]

  def index
    @short_results = ShortResult.all
  end

  def new
    @short_result = ShortResult.new
  end

  def edit
  end

  def create
    p short_result_params
    @short_result = ShortResult.new(short_result_params)
    if @short_result.save
      redirect_to edit_admin_short_result_path(@short_result), notice: '結果を作成しました'
    else
      render :new, error: '結果の作成に失敗しました'
    end
  end

  def update
    if @short_result.update(short_result_params)
      redirect_to edit_admin_short_result_path(@short_result)
    else
      render :edit
    end
  end

  def destroy
    if @short_result.destroy
      redirect_to admin_short_results_path, notice: '削除しました'
    else
      redirect_to edit_admin_short_results_path(@short_result), error: '削除に失敗しました'
    end
  end

  private
  def set_short_result
    @short_result = ShortResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def short_result_params
    params.require(:short_result).permit(
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

  def short_competition_options
    @competition_options = []
    Competition.where(kind: :short).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end
end
