# frozen_string_literal: true

# == Schema Information
#
# Table name: road_results
#
#  id               :bigint           not null, primary key
#  condition        :string
#  established_date :date
#  finish           :integer
#  grade            :string
#  information      :string
#  official         :boolean
#  result           :bigint
#  round            :string
#  athlete_id       :integer
#  competition_id   :integer
#  tournament_id    :integer
#
class RoadResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  belongs_to :competition

  before_save :set_grade

  private

  def set_grade
    self.grade = athlete.grade if grade.blank?
  end
end
