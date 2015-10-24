require 'rails_helper'

feature 'As a user, I want to be able to see a list of posts so that I can learn more things today' do
  context 'user vists show path' do
    before do
      create(:post, title: "Single Post Test", created_at: "2015-10-23")
      visit post_path(Post.last)
    end

    scenario 'user sees single post' do
      expect(page).to have_content(Post.last.title)
      expect(page).to have_content("October 23, 2015")
      expect(page).to_not have_content(build(:post).title)
    end

  end


end
