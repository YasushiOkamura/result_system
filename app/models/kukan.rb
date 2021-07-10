# frozen_string_literal: true

# == Schema Information
#
# Table name: kukans
#
#  id           :bigint           not null, primary key
#  athlete      :string
#  distance     :float
#  kukan_number :integer
#  memo         :text
#  ekiden_id    :integer
#
class Kukan < ApplicationRecord
  belongs_to :ekiden
end
