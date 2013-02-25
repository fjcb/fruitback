# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?
  #FactoryGirl.create(:admin)
  #FactoryGirl.create(:comment)
  #FactoryGirl.create(:comment)
  
  FactoryGirl.create(:site)
  FactoryGirl.create(:site)
end

User.create name: "Fritz Jacob", email: "fjacob@tzi.de", password: "adminadmin", admin: true
User.create name: "Robert Kuhfss", email: "kuhfss@tzi.de", password: "adminadmin", admin: true