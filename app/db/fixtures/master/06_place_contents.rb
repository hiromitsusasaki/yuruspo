place1 = Place.find_by(name: "ゆるゆるスポーツセンター")
place2 = Place.find_by(name: "だらだらスポーツセンター")

bask = Content.find_by(name: "バスケ")
foot = Content.find_by(name: "フットサル")
vall = Content.find_by(name: "バレー")
base = Content.find_by(name: "野球")
tenn = Content.find_by(name: "テニス")
badm = Content.find_by(name: "バドミントン")

PlaceContent.seed do |s|
  s.id = 0
  s.place = place1
  s.content = bask
end

PlaceContent.seed do |s|
  s.id = 1
  s.place = place1
  s.content = foot
end

PlaceContent.seed do |s|
  s.id = 2
  s.place = place1
  s.content = vall
end

PlaceContent.seed do |s|
  s.id = 3
  s.place = place2
  s.content = base
end

PlaceContent.seed do |s|
  s.id = 4
  s.place = place2
  s.content = tenn
end

PlaceContent.seed do |s|
  s.id = 5
  s.place = place2
  s.content = badm
end
