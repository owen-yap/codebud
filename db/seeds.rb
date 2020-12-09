# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying current db....'
Skill.destroy_all

puts 'Seeding current db....'

%w[Ruby Python JS C PHP Laravel Lisp Java Perl Rails SQL Swift Django].each do |skill|
  skill = Skill.new(name: skill)
  skill.save!
  puts 'Skill instance saved!👍'
end

puts 'Seeding Done 👍'

# 10.times do
#   user = User.new(name: %w[Tom Tim John Collin Mary].sample, skillset: %w[Ruby Python JS C PHP].sample)
#   user.save!
#   puts 'User instance saved!👍'
#   question = Question.new(category: %w[Ruby Python JS C PHP].sample, description: 'sample desc', price: (10..30).to_a.sample)
#   question.user = user # assign question to user
#   question.save!
#   puts 'Question instance saved!👍'
#   order = Order.new(status: 'pending tutor')
#   order.user = user # assign order to user
#   order.save!
#   puts 'Order instance saved!👍'
#   review = Review.new(rating: (1..5).to_a.sample, content: 'sample cont')
#   review.order = order # assign review to order
#   # review.order.user = user # assign review to user
#   review.save!
#   puts 'User instance saved!👍'
# end