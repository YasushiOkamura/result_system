class FieldResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  before_save :set_grade
  before_save :set_official

  private

  def set_grade
    self.grade = self.athlete.grade if self.grade.blank?
  end

  def set_official
    self.official = false if (self.wind && self.wind > 2.0) || self.official.blank?
  end
end
