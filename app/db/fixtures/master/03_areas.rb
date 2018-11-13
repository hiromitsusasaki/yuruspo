require 'csv'

csv = CSV.read('./db/master_data/area.csv')

csv.each_with_index do |area, i|
  next if i === 0

  city_name = area[0]
  area_name = area[1]

  city = City.find_by(name: city_name)
  Area.seed do |a|
    a.name = area_name
    a.city = city
  end
end