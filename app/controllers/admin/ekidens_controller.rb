class Admin::EkidensController < Admin::BaseController
  before_action :set_ekiden, only: [:edit, :update, :destroy, :show]

  def index
    @q = Ekiden.ransack(params[:q])
    @q.sorts = 'id asc' if @q.sorts.empty?
    @ekidens = @q.result(distinct: true).page(params[:page])
  end

  def new
    @ekiden = Ekiden.new
  end

  def edit
  end

  def create
    @ekiden = Ekiden.new(ekiden_params)
    if @ekiden.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_ekiden_path(@ekiden)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @ekiden.update(ekiden_params)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_ekiden_path(@ekiden)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @ekiden.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_ekidens_path
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_ekidens_path(@ekiden)
    end
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ekiden
    @ekiden = Ekiden.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ekiden_params
    params.require(:ekiden).permit(:name, :start_at, :place, :kukans_count, :points_count)
  end
end
