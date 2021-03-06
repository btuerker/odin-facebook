# frozen_string_literal: true

# Generate Users
User.create!(first_name: 'Burhan',
             last_name: 'Tuerker',
             email: 'burhan.tuerker@gmail.com',
             password: 'password',
             profile_photo: Rails.root.join('app/assets/images/seed/users/user.jpg').open,
             cover_photo: Rails.root.join('app/assets/images/seed/users/lana_del_rey.jpg').open)

(1..5).each do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "user#{i}@mail.com"
  password = 'password'
  profile_photo = Rails.root.join("app/assets/images/seed/users/user_#{i}.jpg").open
  cover_photo = Rails.root.join('app/assets/images/seed/users/lana_del_rey.jpg').open

  User.create!(first_name: first_name, last_name: last_name, email: email, password: password,
               profile_photo: profile_photo, cover_photo: cover_photo)
end

(6..50).each do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "user#{i}@mail.com"
  password = 'password'

  User.create!(first_name: first_name, last_name: last_name, email: email, password: password)
end

# Generate friendships
user = User.first
User.all.where.not(id: user.id).limit(30).each do |u|
  user.direct_friends << u
end

# Generate Posts

User.take(6).each do |u|
  10.times do
    u.posts.create!(content: Faker::Lorem.paragraph_by_chars(number: 180),
                    photo: Rails.root.join("app/assets/images/seed/posts/post_#{(1..10).to_a.sample}.jpg").open)
  end
end

# Generate Comments
posts = Post.take(5)
User.take(6).each do |u|
  posts.each do |p|
    p.comments.create!(user: u, content: Faker::Lorem.paragraph_by_chars(number: 150))
  end
end

# Generate Likes
posts = Post.take(5)
User.take(6).each do |u|
  posts.each do |p|
    p.likes.create!(user: u)
  end
end
