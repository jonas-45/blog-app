require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let(:user) { User.create(name: 'John Doe', photo: 'john.jpg', bio: 'John Doe is from Ghana') }

  scenario 'Displaying user post information' do
    # Create sample posts for the user
    post1 = Post.create(author: user, title: 'Post 1', text: 'Post 1 content', comments_counter: 2, likes_counter: 5)
    post2 = Post.create(author: user, title: 'Post 2', text: 'Post 2 content', comments_counter: 3, likes_counter: 7)

    # Visit the user post index page
    visit user_posts_path(user)

    # Assertions
    expect(page).to have_css('img')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.post_counter}")
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
    expect(page).to have_content("Comments: #{post1.comments_counter}")
    expect(page).to have_content("Comments: #{post2.comments_counter}")
    expect(page).to have_content("Likes: #{post1.likes_counter}")
    expect(page).to have_content("Likes: #{post2.likes_counter}")
    expect(page).to have_link('View post')

    # Click on a post
    click_link post1.title

    # Assertions for redirected page
    expect(current_path).to eq(user_post_path(user, post1))
  end
end
