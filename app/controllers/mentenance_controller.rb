# frozen_string_literal: true

class MentenanceController < ApplicationController
  skip_before_action :check_mentenance, raise: false
  def index
  end
end
