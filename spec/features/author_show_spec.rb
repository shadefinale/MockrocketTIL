require 'rails_helper'

feature 'As a user, I want to be able to click on the name of the post author so that I can see more posts by that author.' do
  before do
    author = create(:author)
    create(:post, author: author)
    create(:post)
    create(:post, author: author)
    create(:post, author: author)
    create(:post)
    visit root_path
  end

  context 'user visits root path' do
    scenario 'user can click on author to go to author show page' do
      expect(page).to have_content(Author.first.username)
      click_link(Author.first.username, match: :first)
      expect(page).to have_selector(".post", count: 3)
    end
  end

  context 'user visits show path' do
    scenario 'user can click on author from post show page to go to author show page' do
      visit post_path(Post.first)
      expect(page).to have_content(Author.first.username)
      click_link(Author.first.username, match: :first)
      expect(page).to have_selector(".post", count: 3)
    end
  end
end
