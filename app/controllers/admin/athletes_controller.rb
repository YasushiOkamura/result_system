# frozen_string_literal: true

class Admin::AthletesController < Admin::BaseController
  before_action :set_athlete, only: %i[edit update destroy]

  def index
    @q = Athlete.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
    @athletes = @q.result(distinct: true).page(params[:page])
  end

  def new
    @athlete = Athlete.new
  end

  def edit
  end

  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.save
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_athlete_path(@athlete)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def update
    if @athlete.update(athlete_params)
      flash[:notice] = "更新しました"
      redirect_to edit_admin_athlete_path(@athlete)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @athlete.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_athletes_path
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to edit_admin_athletes_path(@athlete)
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
