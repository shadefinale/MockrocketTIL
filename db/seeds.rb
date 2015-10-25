srand(12345)
Post.destroy_all

Post.destroy_all
Author.destroy_all
Tag.destroy_all

10.times do
  Author.create(username: Faker::Internet.user_name(nil, %w(- _)))
end

20.times do
  Tag.create(name: Faker::Company.buzzword)
end

10.times do
  Author.all.each do |author|
    rand(0..2).times do |idx|
      author.posts.create(title: Faker::Lorem.sentence,
                          body: Faker::Lorem.paragraph(5, true, 5),
                          likes: rand(0..5),
                          tag: Tag.all.sample)
    end
  end
end

