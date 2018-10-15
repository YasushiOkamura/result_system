class Admin::SessionsController < Admin::BaseController
  layout 'application'
  skip_before_action :authenticate!, only: [:new, :create], raise: false

  def new
    @manager = Manager.new
    redirect_to admin_root_path, notice: '既にログインしています' if @current_manager
  end

  def create
    manager = Manager.find_by(login_id: manager_params[:login_id])

    if manager&.authenticate(manager_params[:password])

      session[:manager_id] = manager.id
      redirect_to admin_root_path, layout: 'admin/application', notice: 'ログインしました'
    else
      @manager = Manager.new(login_id: manager_params[:login_id])
      render 'new', notice: 'ログインに失敗しました'
    end
  end

  def destroy
    logout!
    redirect_to root_path, notice: 'ログアウトしました', layout: 'application'
  end

  private

  def manager_params
    params.require(:manager).permit(:login_id, :password)
  end
end

