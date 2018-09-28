class ShortResult < ApplicationRecord
  belongs_to :athlete, optional: true
  belongs_to :tournament, optional: true
  
  before_save :set_grade
  before_save :set_official

  private

  def set_grade
    self.grade = self.athlete.grade
  end

  def set_official
    if self.wind && self.wind > 2.0
      self.official = false
    else
      self.official = true
    end
  end
end
