class Tournament < ApplicationRecord
  has_many :short_results
  has_many :long_results
  has_many :field_results
  has_many :relay_results
  has_many :decathlon_results

  validates :name, :start_day, :end_day, presence: true

  def get_result_num
    self.short_results.size + self.long_results.size + self.field_results.size + self.relay_results.size + self.decathlon_results.size
  end
end
