# frozen_string_literal: true

class Admin::BaseController < ActionController::Base
  layout 'admin/base'
  before_action :authenticate!
  before_action :check_mobile
  helper_method :current_manager

  class Forbidden < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  def result_parse(result)
    res = result.split('.').reverse
    case res.size
    when 1
      res[0].to_i
    when 2
      res[0].to_i * (10**(3 - res[0].length)) + res[1].to_i * 1000
    when 3
      res[0].to_i * (10**(3 - res[0].length)) + res[1].to_i * 1000 + res[2].to_i * 1000 * 60
    when 4
      res[0].to_i * (10**(3 - res[0].length)) + res[1].to_i * 1000 + res[2].to_i * 1000 * 60 + res[3].to_i * 1000 * 60 * 60
    end
  end

  protected

  def logout!
    session[:manager_id] = nil
  end

  def current_manager
    @current_manager ||= Manager.find(session[:manager_id]) if session[:manager_id]
  rescue ActiveRecord::RecordNotFound
    logout!
  end

  def authenticate!
    redirect_to admin_new_session_path unless current_manager
  end

  def check_mobile
    @smartphone = request.from_smartphone?
  end
end
