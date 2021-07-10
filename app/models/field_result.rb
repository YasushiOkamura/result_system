# frozen_string_literal: true

# == Schema Information
#
# Table name: field_results
#
#  id               :bigint           not null, primary key
#  condition        :string
#  established_date :date
#  finish           :integer
#  grade            :string
#  information      :string
#  official         :boolean
#  result           :float
#  round            :string
#  wind             :float
#  athlete_id       :integer
#  competition_id   :integer
#  tournament_id    :integer
#
class FieldResult < ApplicationRecord
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
