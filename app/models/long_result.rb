# frozen_string_literal: true

# == Schema Information
#
# Table name: long_results
#
#  id               :bigint           not null, primary key
#  condition        :string
#  established_date :date
#  finish           :integer
#  grade            :string
#  group            :string
#  information      :string
#  official         :boolean
#  rane             :string
#  result           :bigint
#  round            :string
#  athlete_id       :integer
#  competition_id   :integer
#  tournament_id    :integer
#
class LongResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament
  belongs_to :competition

  before_save :set_grade

  private

  def set_grade
    self.grade = athlete.grade if grade.blank?
  end
end
