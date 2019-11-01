# frozen_string_literal: true

class LoadResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
end
