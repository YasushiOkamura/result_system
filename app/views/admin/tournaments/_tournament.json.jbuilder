# frozen_string_literal: true

json.extract! tournament, :id, :created_at, :updated_at
json.url tournament_url(tournament, format: :json)
