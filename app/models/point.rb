# frozen_string_literal: true

# == Schema Information
#
# Table name: points
#
#  id        :bigint           not null, primary key
#  name      :string
#  ekiden_id :integer
#
class Point < ApplicationRecord
  belongs_to :ekiden
end
