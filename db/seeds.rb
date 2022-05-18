# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Listing.destroy_all
Booking.destroy_all
Review.destroy_all
Role.destroy_all
Subject.destroy_all

student = User.create(name: 'John Smith', bio: 'Example bio', email: 'student@test.com', password: 'student123')
student.add_role :student

tutor = User.create(name: 'Jane Begley', bio: 'Example bio', email: 'tutor@test.com', password: 'tutor123')
tutor.add_role :tutor

subjects = %w[English Maths Science]

subjects.each do |subject|
  Subject.create(name: subject)
end

listing = Listing.create(tutor: tutor, title: 'Listing 1', content: 'Some content')
listing.subjects << Subject.find_by(name: 'English')

p booking = Booking.create(student: student,  listing: listing, start: DateTime.new(2022, 6, 6, 12, 30, 0),
                         finish: DateTime.new(2022, 6, 6, 13, 30, 0))

p review = Review.create(tutor: tutor, student: student, content: 'Some content', rating: 5)

student.saved_listings << listing

puts "role count: #{Role.count}"
puts "user count: #{User.count}"
puts "review count: #{Review.count}"
puts "Listing count: #{Listing.count}"
puts "John Smiths saved listing: #{student.saved_listings.first.title}"
puts "Booking count: #{Booking.count}"
puts "Subject count: #{Subject.count}"
puts "Jane Begleys Listings Subjects: #{listing.subjects.map(&:name)}"
