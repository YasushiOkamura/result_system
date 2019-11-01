# frozen_string_literal: true

json.extract! athlete, :id, :created_at, :updated_at
json.url athlete_url(athlete, format: :json)
