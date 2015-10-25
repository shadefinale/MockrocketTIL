# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.destroy_all

5.times do |idx|
  tag = Tag.create(name: "Tag #) #{idx}")
  author = Author.create(username: "Mr_#{idx}")
  Post.create(title: "My awesome post #)#{idx} ",
              body: "Lorem Ipsum",
              tag: tag,
              author: author)
end
