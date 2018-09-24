class FieldResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  before_save :set_grade

  private

  def set_grade
    self.grade = self.athlete.grade
  end
end
