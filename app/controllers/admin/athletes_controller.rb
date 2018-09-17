class Admin::AthletesController < Admin::ApplicationController
  before_action :set_athlete, only: [:show, :edit, :update, :destroy]

  def index
    @athletes = Athlete.all
  end

  def show
  end

  def new
    @athlete = Athlete.new
  end

  def edit
  end

  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.save
      redirect_to edit_admin_athlete_path(@athlete)
    else
      render :edit
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
    @athlete.destroy
    redirect_to admin_athletes_url, notice: 'Athlete was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete
      @athlete = Athlete.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athlete_params
      params.fetch(:athlete, {})
    end
end
