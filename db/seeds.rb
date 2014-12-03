# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: 'user@user.com',  password: 'foobarbaz')
Zone.create(name: 'Hora em Fernando de Noronha', city_name: "America/Noronha", minutes_offset: -120)