# frozen_string_literal: true

class Admin::KukansController < Admin::BaseController
  before_action :set_ekiden
  before_action :set_kukan, only: %i[edit update destroy]

  def index
    @kukans = Kukan.where(ekiden_id: @ekiden.id).order("kukan_number asc")
  end

  def new
    @kukan = Kukan.new
  end

  def edit
  end

  def create
    @kukan = Kukan.new(kukan_params.merge(ekiden_id: @ekiden.id))
    if @kukan.save
      flash[:notice] = "新規作成しました"
      redirect_to admin_ekiden_kukans_path(@ekiden)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def update
    if @kukan.update(kukan_params)
      flash[:notice] = "更新しました"
      redirect_to admin_ekiden_kukans_path(@ekiden)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    flash[:notice] = if @kukan.destroy
                       "削除しました"
                     else
                       "削除に失敗しました"
                     end
    redirect_to admin_ekiden_kukans_path(@ekiden)
  end

  private

    def set_ekiden
      @ekiden = Ekiden.find(params[:ekiden_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_kukan
      @kukan = Kukan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kukan_params
      params.require(:kukan).permit(:kukan_number, :distance, :athlete, :memo)
    end
end
