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

tutor1 = User.new(name: Faker::Name.unique.name,
                email: Faker::Internet.email,
                username: Faker::Name.unique.name,
                tutor: true,
                password: "lewagon")
tutor1.skills << Skill.find_by_name("Python")
tutor1.skills << Skill.find_by_name("Javascript")
tutor1.save!

tutor2 = User.new(name: Faker::Name.unique.name,
                email: Faker::Internet.email,
                username: Faker::Name.unique.name,
                tutor: true,
                password: "lewagon")
tutor2.skills << Skill.find_by_name("Ruby")
tutor2.skills << Skill.find_by_name("Rails")
tutor2.save!



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

proposal1 = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
proposal1.question = Question.first
proposal1.user = tutor1
puts "Proposal created 💍" if proposal1.save!

proposal2 = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
proposal2.question = Question.first
proposal2.user = tutor2
puts "Proposal 2 created 💍" if proposal2.save!

puts "Completed ✨✨✨"
