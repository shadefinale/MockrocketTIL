require 'rails_helper'

feature 'As a user, I want to be able to see a list of posts so that I can learn more things today' do
  context 'user vists show path' do
    before do
      create(:post, title: "Single Post Test", created_at: "2015-10-23")
      visit post_path(Post.first)
    end

    scenario 'user sees single post' do
      expect(page).to have_content(Post.last.title)
      expect(page).to have_content("October 23, 2015")
      expect(page).to_not have_content(build(:post).title)
    end


    scenario 'user vists non-existant post id' do
      visit post_path(Post.last.id + 1)
      expect(current_path).to eq(posts_path)
    end

  end

  context 'previous/next post links' do
    before do
      Post.destroy_all
      @first_post = create(:post)
      @middle_post = create(:post)
      @last_post = create(:post)
      visit post_path(Post.first)
    end

    scenario 'user on first post page' do
      # Steve is a guy who is already looking the very first ever published

      # He sees that on the first post page, there is no link to go backward,
      # so Steve just clicks the 'Next Post' button.
      expect(page).to_not have_content('Previous Post')
      click_link('Next Post')

      # Steve sees now that he's on the next Post.
      # Then, Steve notices that he can go backwards OR forwards. He opts to go
      # backwards.
      expect(current_path).to eq(post_path(@middle_post))
      expect(page).to have_content('Previous Post')
      expect(page).to have_content('Next Post')
      click_link('Previous Post')

      # Steve finds himself back on the first post, and decides to go forward
      # once again.
      expect(current_path).to eq(post_path(@first_post))
      expect(page).to_not have_content('Previous Post')
      click_link('Next Post')

      # Steve sees now that he's on the second Post once more.
      # Steve then decides to click on the next post link and finds that he is
      # on the third post.
      expect(current_path).to eq(post_path(@middle_post))
      click_link('Next Post')

      # Steve finds himself on the next post, notices that there is no post
      # after it, and decides to go back to the second post.
      expect(current_path).to eq(post_path(@last_post))
      expect(page).to_not have_content('Next Post')
      click_link('Previous Post')

      # Steve ends on the second post.
      expect(current_path).to eq(post_path(@middle_post))
    end
  end
end
