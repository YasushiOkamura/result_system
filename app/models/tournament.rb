class Tournament < ApplicationRecord
  has_many :short_results
  has_many :long_results
  has_many :field_results
  has_many :relay_results
end
