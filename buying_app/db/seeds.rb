# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

150.times do
  # guest = Guest.create(guest.id_book = SecureRandom.uuid
  # guest.name = Faker::Name.name
  # guest.age = rand(12..60)
  # guest.doc_type = %w[passport born_cert driving_licence][rand(3)]
  # guest.doc_num = rand(100000..999999).to_s

  guest = Guest.create(id_book: SecureRandom.uuid,
    name: Faker::Name.name,
    age: rand(12..60),
    doc_type: %w[passport born_cert driving_licence][rand(3)],
    doc_num: rand(100000..999999).to_s)

  Ticket.create(id_guest: guest.id,
    name: guest.name,
    age: guest.age,
    doc_type: guest.doc_type,
    doc_num: guest.doc_num,
    category: %w[vip fan][rand(2)],
    date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    price: rand(1000..2500))

  # ticket = Ticket.create
  # ticket.id_guest = guest.id
  # ticket.name = guest.name
  # ticket.age = guest.age
  # ticket.doc_type = guest.doc_type
  # ticket.doc_num = guest.doc_num
  # ticket.category = 
  # ticket.date = Faker::Date.between(from: 1.year.ago, to: Date.today)
  # ticket.price = rand(1000..2500)
end
