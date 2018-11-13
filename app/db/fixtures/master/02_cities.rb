require 'csv'

csv = CSV.read('./db/master_data/city.csv')

csv.each_with_index do |city, i|
  next if i === 0

  pref_name = city[0]
  city_name = city[1]

  prefecture = Prefecture.find_by(name: pref_name)
  City.seed do |c|
    c.name = city_name
    c.prefecture = prefecture
  end
end