# frozen_string_literal: true

class Competition < ApplicationRecord
  enumerize :kind, in: %i[short long field relay decathlon heptathlon road]
  validates :name, uniqueness: true
end
