# frozen_string_literal: true

# == Schema Information
#
# Table name: ekidens
#
#  id           :bigint           not null, primary key
#  kukans_count :integer
#  name         :string
#  place        :string
#  points_count :integer
#  start_at     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Ekiden < ApplicationRecord
  has_many :kukans
  has_many :points
  has_many :raps
end
