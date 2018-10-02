class Admin::SessionsController < Admin::ApplicationController
  layout 'application'
  skip_before_action :authenticate!, only: [:new, :create]

  def new
    @manager = Manager.new
    redirect_to after_login_path, notice: '既にログインしています' if current_manager
  end

  def create
    manager = Manager.find_by(login_id: manager_params[:login_id])

    if manager&.authenticate(manager_params[:password])
      session[:manager_id] = manager.id
      redirect_to admin_root_path, notice: 'ログインしました'
    else
      @manager = Manager.new(login_id: manager_params[:login_id])
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    logout!
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def manager_params
    params.require(:manager).permit(:login_id, :password)
  end
end

