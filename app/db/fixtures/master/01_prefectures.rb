require 'csv'

csv = CSV.read('./db/master_data/prefecture.csv')

csv.each_with_index do |pref, i|
  next if i === 0

  p name = pref[0]

  Prefecture.seed do |s|
    s.id = i - 1
    s.name = name
  end
end
