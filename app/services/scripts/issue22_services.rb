# frozen_string_literal: true

module Scripts
  class Issue22Services
    def execute
      build_competition_id_column
      update_competition_name_ja
    end

    private

      def build_competition_id_column
        short_competitions = Competition.where(kind: :short).index_by(&:name)
        long_competitions = Competition.where(kind: :long).index_by(&:name)
        field_competitions = Competition.where(kind: :field).index_by(&:name)
        relay_competitions = Competition.where(kind: :relay).index_by(&:name)
        short_results = ShortResult.all.map { |r| r.competition_id = short_competitions[r.competition].id; r }
        long_results = LongResult.all.map { |r| r.competition_id = long_competitions[r.competition].id; r }
        field_results = FieldResult.all.map { |r| r.competition_id = field_competitions[r.competition].id; r }
        relay_results = RelayResult.all.map { |r| r.competition_id = relay_competitions[r.competition].id; r }
        ShortResult.import(short_results,
                           on_duplicate_key_update: { columns: [:competition_id], conflict_target: [:id] })
        LongResult.import(long_results, on_duplicate_key_update: { columns: [:competition_id], conflict_target: [:id] })
        FieldResult.import(field_results,
                           on_duplicate_key_update: { columns: [:competition_id], conflict_target: [:id] })
        RelayResult.import(relay_results,
                           on_duplicate_key_update: { columns: [:competition_id], conflict_target: [:id] })
      end

      def update_competition_name_ja
        competitions = Competition.all.map { |c| c.name = I18n.t("enumerize.competition.name.#{c.name}"); c }
        Competition.import(competitions, on_duplicate_key_update: { columns: [:name], conflict_target: [:id] })
      end
  end
end
