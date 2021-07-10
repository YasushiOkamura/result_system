# frozen_string_literal: true

module ApplicationHelper
  def show_result(result)
    return "" if result.nil?

    ms = result % 1000
    # ms = ms.to_s.rjust(2, '0')
    ms = ms.to_s.rjust(3, "0")[0..1]
    s = result / 1000
    m = s / 60
    s = s % 60
    return "#{s.to_s[0, 2]}.#{ms.to_s[0, 2].rjust(2, "0")}" if m.zero?

    if m < 60
      "#{m.to_s[0, 2]}.#{s.to_s[0, 2].rjust(2, "0")}.#{ms.to_s[0, 2].rjust(2, "0")}" unless m.zero?
    else
      h = m / 60
      m = m % 60
      "#{h}.#{m.to_s[0, 2]}.#{s.to_s[0, 2].rjust(2, "0")}.#{ms.to_s[0, 2].rjust(2, "0")}"
    end
  end

  def show_field_result(result)
    return "" unless result.present?

    "%.2f" % result.to_s
  end

  def show_wind(wind)
    return "" if wind.nil?
    return "+#{wind}" if wind >= 0

    wind
  end
end
