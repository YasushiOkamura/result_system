module ApplicationHelper
  def show_result(result)
    return "" if result.nil?
    ms = result % 1000 % 100
    ms = ms.to_s.rjust(2, '0')
    s = result / 1000
    m = s / 60
    s = s % 60
    return "#{s}.#{ms}" if m.zero?
    "#{m}.#{s}.#{ms}" unless m.zero?
  end

  def show_wind(wind)
    return "" if wind.nil?
    return "+#{wind}" if wind >= 0
    wind
  end
end
