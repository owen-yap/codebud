require 'faker'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'httparty'

puts 'Destroying current db....'
Skill.destroy_all
Message.destroy_all
Order.destroy_all
User.destroy_all

puts 'Seeding current db....'
url = 'https://api.stackexchange.com/2.2/questions?pagesize=5&order=desc&sort=activity&site=stackoverflow'
data = JSON.parse(open(url).read)


puts 'skills creation......🎂'
%w[Ruby Ruby_on_Rails Python Javascript C PHP Laravel HTML CSS Java Perl SQL Swift Django].each do |skill|
  skill = Skill.new(name: skill)
  skill.save!
end
puts 'Skill instance saved!👩‍🏫'

data['items'].each do |set|
  url_so = set['link']
  puts 'user creation....🦆'
  
  user = User.new(username: set['owner']['display_name'].gsub(" ", "_"),
  name: set['owner']['display_name'],
  email: set['owner']['display_name'].downcase.gsub(" ", "_") + '@gmail.com',
  password: "lewagon"
  )
  user = User.find_by(email: set['owner']['display_name'].downcase.gsub(" ", "_") + '@gmail.com') if !user.valid?
  
  user.skills << Skill.find(rand(1..14))
  user.save!

  # skill_name = set['tags'][0].capitalize
  # if Skill.find_by(name: skill_name).nil?
  #   skill = Skill.new(name: skill_name )
  #   skill.save!
  # else
  #   skill = Skill.find_by(name: skill_name)
  # end

  puts 'bio creation......☣'
  url_user = set['owner']['link']
  html_doc1 = Nokogiri::HTML(open(url_user).read)
  bio = Bio.new

  html_doc1.search('.profile-user--bio > p').each do |element|
    bio.content = element.text.strip
  end
  user.bio = bio
  bio.save!

  puts 'scraping & question creation.....🙌'
  html_doc = Nokogiri::HTML(open(url_so).read)
  question = Question.new
  html_doc.search('.js-post-body').each do |element|
    question.rich_body = element.text.strip #this gets description
  end
  html_doc.search('#question-header > h1 > a').each do |element|
    question.title = element.text.strip
  end
  question.budget = (15..39).to_a.sample
  question.start_time = Time.strptime('06/30/2020 12:34', '%m/%d/%Y %H:%M')
  question.end_time = Time.strptime('07/15/2020 10:04', '%m/%d/%Y %H:%M')

  question.user = user
  seeded_skill = Skill.find(rand(1..14))
  question.skills << seeded_skill
  question.save!

  puts 'user saved! 🎉🎉🎉'
end

puts 'Creating Proposal'

3.times do
  tutor1 = User.new(name: Faker::Name.unique.name,
                email: Faker::Internet.email,
                username: Faker::Name.unique.name,
                tutor: true,
                password: "lewagon")

  tutor1.skills << Skill.all.sample
  tutor1.skills << Skill.all.sample
  tutor1.bio = Bio.create(content: "")
  tutor1.save!

  prop = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
  prop.question = Question.first
  prop.user = tutor1
  puts "Proposal created 💍" if prop.save!
end

puts "Completed ✨✨✨"
# %w[Ruby Ruby_on_Rails Python Javascript C PHP Laravel HTML CSS Java Perl SQL Swift Django].each do |skill|
#   skill = Skill.new(name: skill)
#   skill.save!
#   puts 'Skill instance saved!👩‍🏫'
# end

# user = User.new(name: "John",
#                 email: "abc@gmail.com",
#                 username: "JohnDoe",
#                 tutor: false,
#                 password: "lewagon")
# user.bio = Bio.create(content: "I am currently going through university and need to get past my python mods. Someone please help me")
# user.skills << Skill.find_by_name("Python")
# user.save!

# tutor1 = User.new(name: Faker::Name.unique.name,
#                 email: Faker::Internet.email,
#                 username: Faker::Name.unique.name,
#                 tutor: true,
#                 password: "lewagon")
# tutor1.skills << Skill.find_by_name("Python")
# tutor1.skills << Skill.find_by_name("Javascript")
# tutor1.bio = Bio.create(content: "")
# tutor1.save!

# tutor2 = User.new(name: Faker::Name.unique.name,
#                 email: Faker::Internet.email,
#                 username: Faker::Name.unique.name,
#                 tutor: true,
#                 password: "lewagon")
# tutor2.skills << Skill.find_by_name("Ruby")
# tutor2.skills << Skill.find_by_name("Rails")
# tutor2.bio = Bio.create(content: "")
# tutor2.save!



# 3.times do
#   question = Question.new(title: Faker::Quotes::Shakespeare.hamlet_quote,
#                           description: Faker::Quote.matz,
#                           min_price: (1..5).to_a.sample,
#                           max_price: (6..10).to_a.sample,
#                           start_time: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1),
#                           end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now))
#   Skill.all.shuffle.first(2).each do |skill|
#     question.skills << skill
#   end
#   question.user = user
#   question.save!
# end

# proposal1 = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
# proposal1.question = Question.first
# proposal1.user = tutor1
# puts "Proposal created 💍" if proposal1.save!

# proposal2 = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
# proposal2.question = Question.first
# proposal2.user = tutor2
# puts "Proposal 2 created 💍" if proposal2.save!

# proposal3 = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
# proposal3.question = Question.all[1]
# proposal3.user = tutor2
# puts "Proposal 3 created 💍" if proposal3.save!

# puts "Completed ✨✨✨"
