require 'csv'

desc "This task is used to seed the "
task :load_olympians_from_csv => :environment do
  puts "Loading olympians from csv"
  olympians_text = File.read('./data/olympians.csv')
    olympians_csv = CSV.parse(olympians_text, headers: true)
    olympians_csv.each do |row|
      team  = Team.find_or_create_by!(name: row["Team"])
      sport = Sport.find_or_create_by!(name: row["Sport"])
      event = Event.find_or_create_by!(name: row["Event"], sport_id: sport.id)
      olympian = Olympian.find_or_create_by!(
        name:   row["Name"],
        age:    row["Age"],
        sex:    row["Sex"],
        height: row["Height"],
        weight: row["Weight"],
        team_id: team.id
      )
      sport_olympian = SportOlympian.create!(sport_id: sport.id, olympian_id: olympian.id)
      event_olympian = EventOlympian.create!(event_id: event.id, olympian_id: olympian.id)
      medalist = Medalist.create!(event_id: event.id, olympian_id: olympian.id, medal: row["Medal"]) if row["Medal"] != 'NA'
    end
  puts "done."
end