# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

3.times do |i|
  vertical = Vertical.create!(
    name: "Test Vertical #{i}",
    categories_attributes: [
      {
        name: "Test Category #{i}-1",
        state: "active",
        courses_attributes: [
          {name: "Test Course - #{i}-1-1", author: "Test Author - #{i}-1-1", state: "active"},
          {name: "Test Course - #{i}-1-2", author: "Test Author - #{i}-1-2", state: "active"},
          {name: "Test Course - #{i}-1-3", author: "Test Author - #{i}-1-3", state: "active"},
        ],
      },
      {
        name: "Test Category #{i}-2",
        state: "active",
        courses_attributes: [
          {name: "Test Course - #{i}-2-1", author: "Test Author - #{i}-2-1", state: "active"},
          {name: "Test Course - #{i}-2-2", author: "Test Author - #{i}-2-2", state: "active"},
          {name: "Test Course - #{i}-2-3", author: "Test Author - #{i}-2-3", state: "active"},
        ],
      },
    ],
  )
end

# Create SearchKick (Elastic Search) Indexes
Vertical.reindex
Category.reindex
Course.reindex

# Devise user
u = User.new(:email => "test@test.com", :password => 'password', :password_confirmation => 'password')
u.save

# if there is no OAuth application created, create them
if Doorkeeper::Application.count.zero?
  test_client = Doorkeeper::Application.create(name: "Test client", redirect_uri: "", scopes: "")

  puts "OAuth seed client_id: #{test_client.uid}"
  puts "OAuth seed client_secret: #{test_client.secret}"
end

