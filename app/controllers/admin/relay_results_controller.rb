class Admin::RelayResultsController < Admin::ApplicationController
  before_action :set_relay_result, only: [:edit, :update, :destroy]
  before_action :relay_competition_options, only: [:new, :edit, :create, :update, :edit, :destroy]

  def index
    @relay_results = RelayResult.all
  end

  def new
    @relay_result = RelayResult.new
  end

  def edit
  end

  def create
    @relay_result = RelayResult.new(relay_result_params)
    if @relay_result.save
      redirect_to edit_admin_relay_result_path(@relay_result), notice: '結果を作成しました'
    else
      render :new, error: '結果の作成に失敗しました'
    end
  end

  def update
    if @relay_result.update(relay_result_params)
      redirect_to edit_admin_relay_result_path(@relay_result)
    else
      render :edit
    end
  end

  def destroy
    if @relay_result.destroy
      redirect_to admin_relay_results_path, notice: '削除しました'
    else
      redirect_to edit_admin_relay_results_path(@relay_result), error: '削除に失敗しました'
    end
  end

  private

  def set_relay_result
    @relay_result = RelayResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relay_result_params
    params[:relay_result][:result] = result_parse(params[:relay_result][:result])
    params.require(:relay_result).permit(
      :competition,
      :result,
      :round,
      :group,
      :rane,
      :finish,
      :tournament_id,
      :first_athlete_id,
      :second_athlete_id,
      :third_athlete_id,
      :fourth_athlete_id,
      :first_athlete_grade,
      :second_athlete_grade,
      :third_athlete_grade,
      :fourth_athlete_grade,
      :established_date,
      :information,
      :condition
    )
  end

  def relay_competition_options
    @competition_options = []
    Competition.where(kind: :relay).each do |competition|
      @competition_options << [competition.name.text, competition.name]
    end
  end

end
