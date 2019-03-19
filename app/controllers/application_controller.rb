class ApplicationController < ActionController::Base
  layout 'application'
  before_action :check_mobile
  before_action :check_mentenance

  class Forbidden < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  def result_parse(result)
    res = result.split('.').reverse
    case res.size
    when 1
      res[0].to_i
    when 2
      res[0].to_i * (10 ** (3 - res[0].length)) + res[1].to_i * 1000
    when 3
      res[0].to_i * (10 ** (3 - res[0].length)) + res[1].to_i * 1000 + res[2].to_i * 1000 * 60
    end
  end

  private

  def check_mobile
    @smartphone = request.from_smartphone?
  end

  def check_mentenance
    redirect_to mentenance_path if Settings.mentenace
  end
end
