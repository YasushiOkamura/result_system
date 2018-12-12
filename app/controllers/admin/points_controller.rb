class Admin::PointsController < Admin::BaseController
  before_action :set_ekiden
  before_action :set_point, only: [:edit, :update, :destroy]

  def index
    @points = Point.where(ekiden_id: @ekiden.id)
  end

  def new
    @point = Point.new
  end

  def edit
  end

  def create
    @point = Point.new(point_params.merge({ekiden_id: @ekiden.id}))
    if @point.save
      flash[:notice] = '新規作成しました'
      redirect_to admin_ekiden_points_path(@ekiden)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @point.update(point_params)
      flash[:notice] = '更新しました'
      redirect_to admin_ekiden_points_path(@ekiden)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @point.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_ekiden_points_path(@ekiden)
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to admin_ekiden_points_path(@ekiden)
    end
  end

  private
  def set_ekiden
    @ekiden = Ekiden.find(params[:ekiden_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_point
    @point = Point.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def point_params
    params.require(:point).permit(:name)
  end
end
