require 'csv'

#require_relative "./seeds/#{Rails.env}"

def str_to_bool(str)
  return true if str == 'true'
  return false if str == 'false'
  nil
end

# 管理者
manager = Manager.create(login_id: 'uectf', password: 'pass', password_confirmation: 'pass')


# 選手
csv = CSV.read('db/seeds/athlete.csv', headers: true)
csv.each do |data|
  Athlete.create(id: data['id'].to_i, name: data['name'], grade: data['grade'], sex: data['sex'], active: data['active'] == 'true' ? true : false) 
end

# 大会
csv = CSV.read('db/seeds/tournament.csv', headers: true)
csv.each do |data|
  Tournament.create(id: data['id'].to_i, name: data['name'], place: data['place'], start_day: data['start_day'], end_day: data['end_day'])
end

# 競技
csv = CSV.read('db/seeds/competition.csv', headers: true)
csv.each do |data|
  Competition.create(name: data['name'], kind: data['type'])
end

# 競技登録

# 短距離
ShortResult.skip_callback(:save, :before, :set_grade)
csv = CSV.read('db/seeds/short_result.csv', headers: true)
csv.each do |data|
  ShortResult.create(competition: data['competition'], result: data['result'].empty? || data['result'].to_i.zero? ? nil : data['result'].to_i,
                     wind: data['wind'] == 'NULL' || data['wind'].empty? ? nil : data['wind'].to_f, round: data['round'], group: data['group'], rane: data['rane'],
                     finish: data['finish'].empty? ? nil : data['finish'].to_i, athlete_id: data['athlete_id'].to_i, tournament_id: data['tournament_id'].to_i, grade: data['grade'], established_date: data['established_date'],
                     information: data['information'], condition: data['condition'], official: str_to_bool(data['official']))
end
ShortResult.set_callback(:save, :before, :set_grade)

# 長距離
LongResult.skip_callback(:save, :before, :set_grade)
csv = CSV.read('db/seeds/long_result.csv', headers: true)
csv.each do |data|
  LongResult.create(competition: data['competition'], result: data['result'].empty? || data['result'].to_i.zero? ? nil : data['result'].to_i, 
                    round: data['round'], group: data['group'], rane: data['rane'],
                    finish: data['finish'].empty? ? nil : data['finish'].to_i, athlete_id: data['athlete_id'].to_i, tournament_id: data['tournament_id'].to_i, grade: data['grade'], established_date: data['established_date'],
                     information: data['information'], condition: data['condition'], official: str_to_bool(data['official']))
end
LongResult.set_callback(:save, :before, :set_grade)

# フィールド
FieldResult.skip_callback(:save, :before, :set_grade)
csv = CSV.read('db/seeds/field_result.csv', headers: true)
csv.each do |data|
  FieldResult.create(competition: data['competition'], result: data['result'].empty? ? nil : data['result'].to_f,
                     wind: data['wind'] == 'NULL' || data['wind'].empty? ? nil : data['wind'].to_f,round: data['round'],
                     finish: data['finish'].empty? ? nil : data['finish'].to_i, athlete_id: data['athlete_id'].to_i, tournament_id: data['tournament_id'].to_i, grade: data['grade'], established_date: data['established_date'],
                     information: data['information'], condition: data['condition'], official: str_to_bool(data['official']))
end
FieldResult.set_callback(:save, :before, :set_grade)

# リレー
RelayResult.skip_callback(:save, :before, :set_grade)
csv = CSV.read('db/seeds/relay_result.csv', headers: true)
csv.each do |data|
  RelayResult.create(competition: data['competition'], result: data['result'].empty? || data['result'].to_i.zero? ? nil : data['result'].to_i,
                     round: data['round'], group: data['group'], rane: data['rane'], finish: data['finish'].empty? ? nil : data['finish'].to_i,
                     first_athlete_id: data['first_athlete_id'].to_i,  second_athlete_id: data['second_athlete_id'].to_i, third_athlete_id: data['third_athlete_id'].to_i, fourth_athlete_id: data['fourth_athlete_id'].to_i, 
                     tournament_id: data['tournament_id'].to_i, first_athlete_grade: data['first_athlete_grade'], second_athlete_grade: data['second_athlete_grade'], third_athlete_grade: data['third_athlete_grade'],
                     fourth_athlete_grade: data['fourth_athlete_grade'], established_date: data['established_date'], information: data['information'], condition: data['condition'], official: data['official'] == 'true' ? true : false)
end
RelayResult.set_callback(:save, :before, :set_grade)
