User.create!(name: "hoang",
    gender: "Male",
    age: "1998-01-01",
    email: "hoang@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    user_type: 1,
    status: 1,
    status_at: Time.zone.now)
99.times do |n|
    name = "hoang-#{n+1}"
    gender = "Male"
    age = "1998-01-01"
    email = "hoang#{n+1}@gmail.com"
    password = "123456"
    User.create!(name: name,
    gender: gender,
    age: "1998-01-01",
    email: email,
    password: password,
    password_confirmation: password,
    status: 1,
    status_at: Time.zone.now)
end
# Generate microposts for a subset of users.
# users = User.order(:created_at).take(6)
# 50.times do |n|
#     content = "content-#{n+1}"
#     users.each { |user| user.microposts.create!(content: content) }
# end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
