require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  scenario 'Displaying user information' do
    # Create sample users
    user1 = User.create(name: 'John Doe', photo: 'john.jpg', bio: 'John Doe from Ghana')
    user2 = User.create(name: 'Jane Smith', photo: 'jane.jpg', bio: 'John Doe from Ghana')

    # Visit the user index page
    visit users_path

    # Assertions
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_css('img')
    expect(page).to have_content("Number of posts: #{user1.post_counter}")
    expect(page).to have_content("Number of posts: #{user2.post_counter}")

    # Click on a user's name
    click_link user1.name

    # Assertions for redirected page
    expect(current_path).to eq(user_path(user1))
    expect(page).to have_content(user1.name)
  end
end
