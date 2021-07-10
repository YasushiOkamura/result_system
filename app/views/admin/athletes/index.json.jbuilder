# frozen_string_literal: true

json.array! @athletes, partial: "athletes/athlete", as: :athlete
