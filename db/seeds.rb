# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create( email: 'admin@example.com', password: 'adminadmin')
admin.update_attribute :admin, true

site = Site.create( name: "Bananinator", url: "bananinator.com")

idea = Idea.create( title: "New idea", description: "I have an idea..." )
idea.update_attribute :user_id, admin.id
idea.update_attribute :site_id, site.id



Site.create!( name: "Other site", url: "othersite.com")
