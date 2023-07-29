require 'rails_helper'
RSpec.feature 'User Show Page', type: :feature do
  let(:user) { User.create(name: 'John Doe', photo: 'jane.jpg', bio: 'Lorem ipsum') }
  scenario 'Displaying user information' do
    # Create sample posts for the user
    post1 = user.posts.create(title: 'Post 1', text: 'Post 1 content', comments_counter: 2, likes_counter: 5)
    post2 = user.posts.create(title: 'Post 2', text: 'Post 2 content', comments_counter: 3, likes_counter: 7)
    post3 = user.posts.create(title: 'Post 3', text: 'Post 3 content', comments_counter: 1, likes_counter: 2)
    # Visit the user show page
    visit user_path(user)
    # Assertions
    expect(page).to have_css('img')
    expect(page).to have_content(user.name)
    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content(user.bio)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post3.title)
    expect(page).to have_link('See all posts')
    # Go back to the user show page
    visit user_path(user)
    # Click on "See all posts"
    click_link 'See all posts'
    # Assertions for redirected page
    expect(current_path).to eq(user_posts_path(user))
  end
end
