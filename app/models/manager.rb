# frozen_string_literal: true

# == Schema Information
#
# Table name: managers
#
#  id              :bigint           not null, primary key
#  password_digest :string           not null
#  login_id        :string           not null
#
class Manager < ApplicationRecord
  validates :login_id, presence: true, uniqueness: true
  has_secure_password validations: false, raise: false
end
