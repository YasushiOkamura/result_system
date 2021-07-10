# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tournaments = Tournament.order("start_day desc").take(5)
  end
end
