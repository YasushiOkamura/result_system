# frozen_string_literal: true

class Admin::CompetitionsController < Admin::BaseController
  before_action :set_competition, only: %i[edit update destroy]

  def index
    @competitions = Competition.order(:kind, :position)
  end

  def new
    @competition = Competition.new
  end

  def edit; end

  def create
    @competition = Competition.new(competition_params)

    if @competition.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_competition_path(@competition)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @competition.save
      flash[:notice] = '更新しました'
      redirect_to edit_admin_competition_path(@competition)
    else
      flash[:notice] = '更新に失敗しました'
      render :new
    end
  end

  def destroy
    if @competition.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_competitions_path, notice: '削除しました'
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to admin_competitions_path(@competition), error: '削除に失敗しました'
    end
  end

  private

  def set_competition
    @competition = competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:name, :kind, :position)
  end
end
