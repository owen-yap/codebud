require 'faker'

puts 'Destroying current db....'
Message.destroy_all
User.destroy_all
Skill.destroy_all

puts 'Seeding current db....'

%w[Ruby Python Javascript C PHP Laravel Lisp Java Perl Rails SQL Swift Django].each do |skill|
  skill = Skill.new(name: skill)
  skill.save!
  puts 'Skill instance saved!👩‍🏫'
end

user = User.new(name: "John",
                email: "abc@gmail.com",
                username: "JohnDoe",
                tutor: false,
                password: "lewagon")
user.bio = Bio.create(content: "I am currently going through university and need to get past my python mods. Someone please help me")
user.skills << Skill.find_by_name("Python")
user.save!

tutor = User.new(name: Faker::Name.unique.name,
                email: Faker::Internet.email,
                username: Faker::Name.unique.name,
                tutor: true,
                password: "lewagon")
tutor.skills << Skill.find_by_name("Python")
tutor.skills << Skill.find_by_name("Javascript")
tutor.save!

3.times do
  question = Question.new(title: Faker::Quotes::Shakespeare.hamlet_quote,
                          description: Faker::Quote.matz,
                          min_price: (1..5).to_a.sample,
                          max_price: (6..10).to_a.sample,
                          start_time: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1),
                          end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now))
  Skill.all.shuffle.first(2).each do |skill|
    question.skills << skill
  end
  question.user = user
  question.save!
end

proposal = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
proposal.question = Question.all.sample
proposal.user = tutor
puts "Proposal created 💍" if proposal.save!

puts "Completed ✨✨✨"
