namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_users
    create_user_address
    create_yardsales
    create_yardsale_address
    # create_relationships
    create_categories
  end
end

def create_users
  admin = User.create!(first_name: "Admn",
                       last_name:  "User",
                       username:   "adminuser",
                       email:      "admin@mail.com",
                       password:   "yardsale1",
                       password_confirmation: "yardsale1")
  admin.toggle!(:admin)
  10.times do |n|
    first_name = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    username   = "username#{n+1}"
    email      = "user-#{n+1}@mail.com"
    password   = "password1"
    User.create!(first_name: first_name,
                 last_name:  last_name,
                 username:   username,
                 email:      email,
                 password:   password,
                 password_confirmation: password)
  end
end

def create_user_address
  users = User.all
  1.times do
    street = Faker::Address.street_address(false)
    city = Faker::Address.city
    state = Faker::Address.state
    zip_code = Faker::Address.zip_code
    users.each { |user| Address.create!(user_id:  user.id,
                                        street:   street,
                                        city:     city,
                                        state:    state,
                                        zip_code: zip_code) }
  end
end

def create_yardsales
  users = User.all
  20.times do
    title       = Faker::Lorem.sentence(5)
    date        = Time.now.strftime("%b %d, %Y (%A)")
    begin_time  = Time.now.strftime("%I:%M %p")
    end_time    = Time.now.strftime("%I:%M %p")
    description = Faker::Lorem.paragraph(5)
    users.each { |user| user.yardsales.create!(title:       title,
                                               date:        date,
                                               begin_time:  begin_time,
                                               end_time:    end_time,
                                               description: description) }
  end
end

def create_yardsale_address
  yardsales = Yardsale.all
  1.times do
    street = Faker::Address.street_address(false)
    city = Faker::Address.city
    state = Faker::Address.state
    zip_code = Faker::Address.zip_code
    yardsales.each { |yardsale| Address.create!(yardsale_id: yardsale.id,
                                                street:      street,
                                                city:        city,
                                                state:       state,
                                                zip_code:    zip_code) }
  end
end

# def create_relationships
#   users = User.all
#   user  = users.first
#   followed_users = users[2..9]
#   followers      = users[5..8]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end

def create_categories
  categories = ["a", "b", "c"]
  categories.each do |category|
    Category.create!(name: category)
  end
end