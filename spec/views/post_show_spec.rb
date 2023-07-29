require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let(:user) { User.create(name: 'John Doe', photo: 'john.jpg', bio: 'John Doe is from Ghana') }

  scenario 'Displaying post information and comments' do
    # Create a sample post
    post = Post.create(author: user, title: 'Post 1', text: 'Post 1 content')

    # Create comments for the post
    comment1 = Comment.create(author: user, post:, text: 'Comment 1')
    comment2 = Comment.create(author: user, post:, text: 'Comment 2')

    # Visit the post show page
    visit user_post_path(user, post)

    # Assertions
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.author.name)
    expect(page).to have_content("Comments:#{post.comments_counter}")
    expect(page).to have_content("Likes:#{post.likes_counter}")
    expect(page).to have_content(post.text)
    expect(page).to have_content(comment1.author.name)
    expect(page).to have_content(comment2.author.name)
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end
