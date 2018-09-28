class RelayResult < ApplicationRecord
  belongs_to :tournament

  belongs_to :first_athlete,  class_name: :Athlete, foreign_key: :first_athlete_id,  inverse_of: :first_relay_results
  belongs_to :second_athlete, class_name: :Athlete, foreign_key: :second_athlete_id, inverse_of: :second_relay_results
  belongs_to :third_athlete,  class_name: :Athlete, foreign_key: :third_athlete_id,  inverse_of: :third_relay_results
  belongs_to :fourth_athlete, class_name: :Athlete, foreign_key: :fourth_athlete_id, inverse_of: :fourth_relay_results

  before_save :set_grade
  before_save :set_official

  private

  def set_grade
    self.first_athlete_grade  = self.first_athlete.grade
    self.second_athlete_grade = self.second_athlete.grade
    self.third_athlete_grade  = self.third_athlete.grade
    self.fourth_athlete_grade = self.fourth_athlete.grade
  end

  def set_official
    self.official = true
  end
end
