# frozen_string_literal: true

# == Schema Information
#
# Table name: raps
#
#  id          :bigint           not null, primary key
#  athlete     :string
#  broadcasted :boolean          default(FALSE)
#  memo        :text
#  point       :string
#  rap_time    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ekiden_id   :integer
#
class Rap < ApplicationRecord
  belongs_to :ekiden
end
