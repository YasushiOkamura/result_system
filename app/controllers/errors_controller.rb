# frozen_string_literal: true

class ErrorsController < ApplicationController
  def routing_error
    raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
  end
end
