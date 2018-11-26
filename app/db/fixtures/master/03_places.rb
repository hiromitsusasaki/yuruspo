

city1 = City.find_by(name: "渋谷区")
Place.seed do |s|
  s.id = 0
  s.name = "ゆるゆるスポーツセンター"
  s.address = "〒150-0043 東京都渋谷区道玄坂１丁目２"
  s.city = city1
end


city2 = City.find_by(name: "新宿区")
Place.seed do |s|
  s.id = 1
  s.name = "だらだらスポーツセンター"
  s.address = "〒160-0022 東京都新宿区新宿３丁目３８"
  s.city = city2
end
