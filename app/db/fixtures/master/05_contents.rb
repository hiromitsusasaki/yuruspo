
sports_type = EventType.find_by(name: "スポーツ")

Content.seed do |s|
  s.id = 0
  s.name = "バスケ"
  s.event_type = sports_type
end

Content.seed do |s|
  s.id = 1
  s.name = "フットサル"
  s.event_type = sports_type
end

Content.seed do |s|
  s.id = 2
  s.name = "バレー"
  s.event_type = sports_type
end

Content.seed do |s|
  s.id = 3
  s.name = "野球"
  s.event_type = sports_type
end

Content.seed do |s|
  s.id = 4
  s.name = "テニス"
  s.event_type = sports_type
end

Content.seed do |s|
  s.id = 5
  s.name = "バドミントン"
  s.event_type = sports_type
end
