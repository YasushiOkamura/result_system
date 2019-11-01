# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :short_results
  has_many :long_results
  has_many :field_results
  has_many :relay_results
  has_many :decathlon_results

  validates :name, :start_day, :end_day, presence: true

  def get_result_num
    short_results.size + long_results.size + field_results.size + relay_results.size + decathlon_results.size
  end
end
