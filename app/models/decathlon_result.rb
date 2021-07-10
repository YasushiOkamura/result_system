# frozen_string_literal: true

# == Schema Information
#
# Table name: decathlon_results
#
#  id               :bigint           not null, primary key
#  condition        :string
#  established_date :date
#  finish           :integer
#  grade            :string
#  information      :string
#  official         :boolean
#  score_100m       :integer
#  score_110mh      :integer
#  score_1500m      :integer
#  score_400m       :integer
#  score_dt         :integer
#  score_hj         :integer
#  score_jt         :integer
#  score_lj         :integer
#  score_pj         :integer
#  score_sp         :integer
#  total_score      :integer
#  athlete_id       :integer
#  field_dt_id      :integer
#  field_hj_id      :integer
#  field_jt_id      :integer
#  field_lj_id      :integer
#  field_pj_id      :integer
#  field_sp_id      :integer
#  long_1500m_id    :integer
#  sprint_100m_id   :integer
#  sprint_110mh_id  :integer
#  sprint_400m_id   :integer
#  tournament_id    :integer
#
class DecathlonResult < ApplicationRecord
  belongs_to :athlete
  belongs_to :tournament

  belongs_to :short_100m_result, class_name: :ShortResult, foreign_key: :sprint_100m_id, optional: true
  belongs_to :field_lj_result, class_name: :FieldResult, foreign_key: :field_lj_id, optional: true
  belongs_to :field_sp_result, class_name: :FieldResult, foreign_key: :field_sp_id, optional: true
  belongs_to :field_hj_result, class_name: :FieldResult, foreign_key: :field_hj_id, optional: true
  belongs_to :short_400m_result, class_name: :ShortResult, foreign_key: :sprint_400m_id, optional: true
  belongs_to :short_110mh_result, class_name: :ShortResult, foreign_key: :sprint_110mh_id, optional: true
  belongs_to :field_dt_result, class_name: :FieldResult, foreign_key: :field_dt_id, optional: true
  belongs_to :field_pj_result, class_name: :FieldResult, foreign_key: :field_pj_id, optional: true
  belongs_to :field_jt_result, class_name: :FieldResult, foreign_key: :field_jt_id, optional: true
  belongs_to :long_1500m_result, class_name: :LongResult, foreign_key: :long_1500m_id, optional: true

  before_save :set_grade

  private

  def set_grade
    self.grade = athlete.grade
  end
end
