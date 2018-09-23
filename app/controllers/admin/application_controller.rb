class Admin::ApplicationController < ActionController::Base
  layout 'admin/application'
  
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
end
