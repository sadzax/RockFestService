# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

150.times do
    guest = Guest.create
      guest.name = Faker::Name.name
      guest.age = rand(10..60)
    #   doc_type: Faker::Lorem.word
    #   doc_num: Faker::Lorem.word
  
    # Ticket.create(id_guest: guest.id,
    #   name: guest.name,
    #   age: guest.age,
    #   doc_type: guest.doc_type,
    #   doc_num: guest.doc_num,
    #   category: Faker::Lorem.word,
    #   date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    #   price: rand(50..200))
  end
