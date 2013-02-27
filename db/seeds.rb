# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! name: "Fritz Jacob", email: "fjacob@tzi.de", password: "adminadmin", admin: true
User.create! name: "Robert Kuhfss", email: "kuhfss@tzi.de", password: "adminadmin", admin: true

State.create! name: 'none', color: '#363636'
State.create! name: 'Refused', color: '#DA4F49'
State.create! name: 'Under review', color: '#FAA732'
State.create! name: 'Planned', color: '#49AFCD'
State.create! name: 'Started', color: '#006DCC'
State.create! name: 'Completed', color: '#5BB75B'

if Rails.env.development?
  #FactoryGirl.create(:admin)
  #FactoryGirl.create(:comment)
  #FactoryGirl.create(:comment)
  
  FactoryGirl.create(:site)
  FactoryGirl.create(:site)
end
