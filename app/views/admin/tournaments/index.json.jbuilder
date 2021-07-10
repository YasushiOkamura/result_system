# frozen_string_literal: true

json.array! @tournaments, partial: "tournaments/tournament", as: :tournament
