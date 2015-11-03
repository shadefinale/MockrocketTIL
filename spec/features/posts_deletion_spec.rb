require 'rails_helper'

feature 'As a user, I want to be able to delete my post so that I do not spread misinformation' do

  before do
    @author = create(:author, password: "abcd1234", password_confirmation: "abcd1234")
    @other_author = create(:author)
    visit new_author_path
    fill_out_signin_form(username: @author.username, password: "abcd1234")
    click_button("Sign In")
  end

  scenario 'user deletes own post from show page' do
    new_post = create(:post, author: @author)

    visit post_path(new_post)
    click_link('Delete Post')

    expect(Post.find_by_id(new_post.id)).to be_nil
    expect(current_path).to eq(posts_path)
  end

  scenario 'user deletes own post from index page' do
    new_post = create(:post, author: @author)

    visit root_path
    click_link('Delete Post')

    expect(Post.find_by_id(new_post.id)).to be_nil
    expect(current_path).to eq(posts_path)
  end



end
