require "csv"

CSV.foreach('db/area.csv') do |row|
  Area.create(name: row[0])
end

CSV.foreach('db/category.csv') do |row|
  Category.create(name: row[0])
end

CSV.foreach('db/user.csv') do |row|
  User.create(email: row[0], name: row[1])
end
