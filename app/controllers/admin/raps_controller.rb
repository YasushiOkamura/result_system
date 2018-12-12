class Admin::RapsController < Admin::BaseController
  before_action :set_ekiden
  before_action :set_rap, only: [:edit, :update, :destroy]

  def index
    @raps = Rap.where(ekiden_id: @ekiden.id).order('rap_number asc')
  end

  def new
    @rap = Rap.new
  end

  def edit
  end

  def create
    @rap = Rap.new(rap_params.merge({ekiden_id: @ekiden.id}))
    if @rap.save
      flash[:notice] = '新規作成しました'
      redirect_to admin_ekiden_raps_path(@ekiden)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @rap.update(rap_params)
      flash[:notice] = '更新しました'
      redirect_to admin_ekiden_raps_path(@ekiden)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @rap.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_ekiden_raps_path(@ekiden)
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to admin_ekiden_raps_path(@ekiden)
    end
  end

  private
  def set_ekiden
    @ekiden = Ekiden.find(params[:ekiden_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_rap
    @rap = Rap.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rap_params
    params.require(:rap).permit(:rap_number, :distance, :athlete, :memo)
  end
end
