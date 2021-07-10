# frozen_string_literal: true

class ShortResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  belongs_to :competition

  before_save :set_grade
  before_save :set_official

  private

    def set_grade
      self.grade = athlete.grade if grade.blank?
    end

    def set_official
      self.official = false if (wind && wind > 2.0) || official.blank?
    end
end
