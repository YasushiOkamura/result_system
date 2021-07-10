# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id        :bigint           not null, primary key
#  count     :integer          default(0)
#  end_day   :date
#  name      :string
#  place     :string
#  start_day :date
#
class Tournament < ApplicationRecord
  has_many :short_results
  has_many :long_results
  has_many :field_results
  has_many :relay_results
  has_many :decathlon_results

  validates :name, :start_day, :end_day, presence: true
end
