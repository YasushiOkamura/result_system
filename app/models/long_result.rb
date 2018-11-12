class LongResult < ApplicationRecord
  belongs_to :athlete, optional: true
  belongs_to :tournament, optional: true
  
  before_save :set_grade

  private

  def set_grade
    self.grade = self.athlete.grade if self.grade.blank?
  end
end
