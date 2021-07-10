# frozen_string_literal: true

# == Schema Information
#
# Table name: competitions
#
#  id       :bigint           not null, primary key
#  kind     :string
#  name     :string
#  position :integer          default(0)
#
class Competition < ApplicationRecord
  enumerize :kind, in: %i[short long field relay decathlon heptathlon road]
  validates :name, uniqueness: true
end
