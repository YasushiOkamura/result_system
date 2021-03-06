# frozen_string_literal: true

# == Schema Information
#
# Table name: relay_results
#
#  id                   :bigint           not null, primary key
#  condition            :string
#  established_date     :date
#  finish               :integer
#  first_athlete_grade  :string
#  fourth_athlete_grade :string
#  group                :string
#  information          :string
#  official             :boolean
#  rane                 :string
#  result               :bigint
#  round                :string
#  second_athlete_grade :string
#  third_athlete_grade  :string
#  competition_id       :integer
#  first_athlete_id     :integer
#  fourth_athlete_id    :integer
#  second_athlete_id    :integer
#  third_athlete_id     :integer
#  tournament_id        :integer
#
class RelayResult < ApplicationRecord
  belongs_to :tournament
  belongs_to :competition

  belongs_to :first_athlete,  class_name: :Athlete, foreign_key: :first_athlete_id,  inverse_of: :first_relay_results
  belongs_to :second_athlete, class_name: :Athlete, foreign_key: :second_athlete_id, inverse_of: :second_relay_results
  belongs_to :third_athlete,  class_name: :Athlete, foreign_key: :third_athlete_id,  inverse_of: :third_relay_results
  belongs_to :fourth_athlete, class_name: :Athlete, foreign_key: :fourth_athlete_id, inverse_of: :fourth_relay_results

  before_save :set_grade

  private

  def set_grade
    self.first_athlete_grade  = first_athlete.grade if first_athlete_grade.blank?
    self.second_athlete_grade = second_athlete.grade if second_athlete_grade.blank?
    self.third_athlete_grade  = third_athlete.grade if third_athlete_grade.blank?
    self.fourth_athlete_grade = fourth_athlete.grade if fourth_athlete_grade.blank?
  end
end
