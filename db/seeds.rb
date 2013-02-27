# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! name: "Fritz Jacob", email: "fjacob@tzi.de", password: "adminadmin", admin: true
User.create! name: "Robert Kuhfss", email: "kuhfss@tzi.de", password: "adminadmin", admin: true

State.create! name: 'none', color: 'whiteSmoke'
State.create! name: 'Refused', color: '#DA4F49'
State.create! name: 'Under review', color: '#FAA732'
State.create! name: 'Planned', color: '#49AFCD'
State.create! name: 'Started', color: '#006DCC'
State.create! name: 'Completed', color: '#5BB75B'

# demo stuff
customer = User.create! name: "Demo Customer", email: "customer@example.com", password: "customer", customer: true
user1 = User.create! name: "Alice Demo", email: "alice@example.com", password: "demodemo"
user2 = User.create! name: "Bob Demo", email: "bob@example.com", password: "demodemo"
user3 = User.create! name: "Carl Demo", email: "carl@example.com", password: "demodemo"

site = Site.new name: "Demo Site", url: "http://fruitback.digineo.de/feedback_index.html"
site.user = customer
site.save!

idea1 = Idea.new title: "Design", description: "Eure Seite sieht nicht ansprechend aus. Es waere schoen, wenn ihr euer Layout etwas ansehlicher gestalten koenntet. Ansonsten ist alles super!"
idea1.site = site
idea1.user = user1
idea1.save!

idea2 = Idea.new title: "Sprache", description: "Es waere schoen, wenn eure Seite auf deutsch waere - ich kann leider kein Pseudo-Latein.."
idea2.site = site
idea2.user = user2
idea2.save!

comment1 = Comment.new text: "Das sehe ich ganz genau so!"
comment1.idea = idea1
comment1.user = user3
comment1.save!

comment2 = Comment.new text: "Das stimmt, ich verstehe auch kein Wort!"
comment2.idea = idea2
comment2.user = user3
comment2.save!

comment3 = Comment.new text: "Ich habe ein grosses Latinum und verstehe trotzdem nichts.."
comment3.idea = idea2
comment3.user = user1
comment3.save!

vote1 = Vote.new score: 1
vote1.user = user1
vote1.idea = idea1
vote1.save!

vote2 = Vote.new score: 1
vote2.user = user3
vote2.idea = idea1
vote2.save!

vote3 = Vote.new score: 1
vote3.user = user2
vote3.idea = idea2
vote3.save!

vote4 = Vote.new score: 1
vote4.user = user3
vote4.idea = idea2
vote4.save!

vote5 = Vote.new score: 1
vote5.user = user1
vote5.idea = idea2
vote5.save!

response = Response.new text: "Wir sind dran!"
response.state = State.find(5)
response.user = customer
response.idea = idea2
response.save!

if Rails.env.development?
  #FactoryGirl.create(:admin)
  #FactoryGirl.create(:comment)
  #FactoryGirl.create(:comment)
  
  FactoryGirl.create(:site)
  FactoryGirl.create(:site)
end
