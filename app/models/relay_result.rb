class RelayResult < ApplicationRecord
  belongs_to :tournament

  belongs_to :first_athlete,  class_name: :Athlete, foreign_key: :first_athlete_id,  inverse_of: :first_relay_results
  belongs_to :second_athlete, class_name: :Athlete, foreign_key: :second_athlete_id, inverse_of: :second_relay_results
  belongs_to :third_athlete,  class_name: :Athlete, foreign_key: :third_athlete_id,  inverse_of: :third_relay_results
  belongs_to :fourth_athlete, class_name: :Athlete, foreign_key: :fourth_athlete_id, inverse_of: :fourth_relay_results

  before_save :set_grade

  private

  def set_grade
    self.first_athlete_grade  = self.first_athlete.grade if self.first_athlete_grade.blank?
    self.second_athlete_grade = self.second_athlete.grade if self.second_athlete_grade.blank?
    self.third_athlete_grade  = self.third_athlete.grade if self.third_athlete_grade.blank?
    self.fourth_athlete_grade = self.fourth_athlete.grade if self.fourth_athlete_grade.blank?
  end
end
