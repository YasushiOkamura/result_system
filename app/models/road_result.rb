# frozen_string_literal: true

class RoadResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  # belongs_to :competition, optional: true

  before_save :set_grade

  private

  def set_grade
    self.grade = athlete.grade if grade.blank?
  end
end
