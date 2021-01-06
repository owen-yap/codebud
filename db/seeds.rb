require 'faker'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'httparty'

puts 'Destroying current db....'
Skill.destroy_all
Message.destroy_all
Skill.destroy_all
Order.destroy_all
User.destroy_all

# puts 'Seeding current db....'
# url = 'https://api.stackexchange.com/2.2/questions?pagesize=5&order=desc&sort=activity&site=stackoverflow'
# data = JSON.parse(open(url).read)


puts 'skills creation......🎂'
%w[Ruby Ruby_on_Rails Python Javascript C PHP Laravel HTML CSS Java Perl SQL Swift Django R].each do |skill|
  skill = Skill.new(name: skill)
  skill.save!
end
puts 'Skill instance saved!👩‍🏫'

# data['items'].each do |set|
#   url_so = set['link']
#   puts 'user creation....🦆'
  
#   user = User.new(username: set['owner']['display_name'].gsub(" ", "_"),
#   name: set['owner']['display_name'],
#   email: set['owner']['display_name'].downcase.gsub(" ", "_") + '@gmail.com',
#   password: "lewagon"
#   )
#   user = User.find_by(email: set['owner']['display_name'].downcase.gsub(" ", "_") + '@gmail.com') if !user.valid?
  
#   user.skills << Skill.all.sample
#   user.save!

#   puts 'bio creation......☣'
#   url_user = set['owner']['link']
#   html_doc1 = Nokogiri::HTML(open(url_user).read)
#   bio = Bio.new

#   html_doc1.search('.profile-user--bio > p').each do |element|
#     bio.content = element.text.strip
#   end
#   user.bio = bio
#   bio.save!

#   puts 'scraping & question creation.....🙌'
#   html_doc = Nokogiri::HTML(open(url_so).read)
#   question = Question.new
#   html_doc.search('.js-post-body').each do |element|
#     question.rich_body = element.text.strip #this gets description
#   end
#   html_doc.search('#question-header > h1 > a').each do |element|
#     question.title = element.text.strip
#   end
#   question.budget = (15..39).to_a.sample
#   question.start_time = Time.strptime('06/30/2020 12:34', '%m/%d/%Y %H:%M')
#   question.end_time = Time.strptime('07/15/2020 10:04', '%m/%d/%Y %H:%M')

#   question.user = user
#   seeded_skill = Skill.all.sample
#   question.skills << seeded_skill
#   question.save!

#   puts 'user saved! 🎉🎉🎉'
# end

# puts 'Creating Proposal'

# 3.times do
#   tutor1 = User.new(name: Faker::Name.unique.name,
#                 email: Faker::Internet.email,
#                 username: Faker::Name.unique.name,
#                 tutor: true,
#                 password: "lewagon")

#   tutor1.skills << Skill.all.sample
#   tutor1.skills << Skill.all.sample
#   tutor1.bio = Bio.create(content: "")
#   tutor1.save!

#   prop = Proposal.new(price: (1..10).to_a.sample, status: 'pending', meeting_time: DateTime.now )
#   prop.question = Question.first
#   prop.user = tutor1
#   puts "Proposal created 💍" if prop.save!
# end

puts "Completed ✨✨✨"
