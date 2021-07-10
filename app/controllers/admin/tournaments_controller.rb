# frozen_string_literal: true

class Admin::TournamentsController < Admin::BaseController
  before_action :set_tournament, only: %i[edit update destroy show]

  def index
    @q = Tournament.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
    @tournaments = @q.result(distinct: true).page(params[:page])
  end

  def new
    @tournament = Tournament.new
  end

  def edit
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_tournament_path(@tournament)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def update
    if @tournament.save
      flash[:notice] = "更新しました"
      redirect_to edit_admin_tournament_path(@tournament)
    else
      flash[:notice] = "更新に失敗しました"
      render :new
    end
  end

  def destroy
    if @tournament.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_tournaments_path, notice: "削除しました"
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to edit_admin_tournaments_path(@tournament), error: "削除に失敗しました"
    end
  end

  def show
  end

  private

    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def tournament_params
      params.require(:tournament).permit(:name, :place, :start_day, :end_day)
    end
end
