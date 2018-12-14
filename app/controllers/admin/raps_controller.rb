class Admin::RapsController < Admin::BaseController
  before_action :set_ekiden
  before_action :set_rap, only: [:edit, :update, :destroy, :broadcast]
  before_action :set_options, only: [:edit, :new, :create, :update]

  def index
    @raps = Rap.where(ekiden_id: @ekiden.id).order('created_at asc')
  end

  def new
    @rap = Rap.new
  end

  def edit
    @time_sum = Rap.where(ekiden_id: @ekiden.id, athlete: @rap.athlete).sum(:rap_time)
  end

  def create
    @rap = Rap.new(rap_params.merge({ekiden_id: @ekiden.id}))
    @rap.rap_time = get_rap_time
    if @rap.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_ekiden_rap_path(@ekiden, @rap)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def update
    if @rap.update(rap_params)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_ekiden_rap_path(@ekiden, @rap)
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

  def broadcast
    if @rap.update(broadcasted: true)
      Slack::Notifier.new(Settings.webhook_url, username: "駅伝速報", icon_emoji: ":obama:").ping(params[:broadcast_message])
      flash[:notice] = '配信しました'
      redirect_to admin_ekiden_raps_path(@ekiden, @rap)
    else
      flash[:notice] = '更新に失敗しました'
      render :edit
    end
  end

  private
  def set_ekiden
    @ekiden = Ekiden.find(params[:ekiden_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_rap
    if params[:id].nil?
      @rap = Rap.find(params[:rap_id])
    else
      @rap = Rap.find(params[:id])
    end
  end

  def set_options
    @point_options = @ekiden.points.order('id').pluck(:name, :name)
    @athlete_options =  athlete_options
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rap_params
    params.require(:rap).permit(:point, :athlete, :memo)
  end

  # integer[ms]
  def get_rap_time
    last_rap = Rap.where(ekiden_id: @ekiden.id).order('created_at').last
    p Time.zone.now
    p @ekiden.start_at
    if last_rap.nil?
      time_distance_milli_second(Time.zone.now, @ekiden.start_at)
    else
      time_distance_milli_second(Time.zone.now, last_rap.created_at)
    end
  end

  def time_distance_milli_second(a, b)
    ((a - b) * 1000).to_i
  end

  def athlete_options
    options = ['わからん']
    @ekiden.kukans.order('kukan_number').each { |kukan| options << [kukan.kukan_number.to_s + "区 " + kukan.athlete] }
    options
  end
end
