class Admin::AthletesController < Admin::BaseController
  before_action :set_athlete, only: [:edit, :update, :destroy]

  def index
    @athletes = Athlete.page(params[:page])
  end

  def new
    @athlete = Athlete.new
  end

  def edit
  end

  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.save
      redirect_to edit_admin_athlete_path(@athlete), notice: '選手を新たに作成しました'
    else
      render :new, error: '選手の作成に失敗しました'
    end
  end

  def update
    if @athlete.update(athlete_params)
      redirect_to edit_admin_athlete_path(@athlete)
    else
      render :edit
    end
  end

  def destroy
    if @athlete.destroy
      redirect_to admin_athletes_path, notice: '削除しました'
    else
      redirect_to edit_admin_athletes_path(@athlete), error: '削除に失敗しました'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete
      @athlete = Athlete.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athlete_params
      params.require(:athlete).permit(:name, :grade, :sex, :major, :active, :memo)
    end
end
