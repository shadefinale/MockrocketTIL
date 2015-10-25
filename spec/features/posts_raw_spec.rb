require 'rails_helper'

feature 'As a power user, I want to be able to click on "view raw" so that I can get the raw markdown of the post' do
  context 'user viewing raw from different paths' do
    before do
      create(:post)
    end

    scenario 'user viewing from index' do
      visit root_path
      click_link('View Raw')
      expect(page).to have_content(Post.first.body)
      expect(page).to_not have_content(Post.first.title)
    end

    scenario 'user viewing from show page' do
      visit post_path(Post.first)
      click_link('View Raw')
      expect(page).to have_content(Post.first.body)
      expect(page).to_not have_content(Post.first.title)
    end
  end
end
