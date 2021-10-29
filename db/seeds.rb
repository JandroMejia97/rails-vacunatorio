# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "luciano@hotmail.com",document_number: 23456432 ,password_digest: "1234",first_name: "Luciano", last_name: "Loyola", birthdate: "2000-09-08", comorbidity: true)
User.create(first_name: "Azul", last_name: "Martini", email: "puto@gmail.com", password_digest: "$2a$12$3ivwGSvuqHbjnfcyAk8n4.DE8Y1utegeUM0AQNvxVJo15pCt/M382", document_number: 23456789, birthdate: "2000-09-07", comorbidity: false)
