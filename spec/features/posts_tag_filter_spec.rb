require 'rails_helper'

feature 'As a user, I want to be able to click on the tag of the post so that I can see similarly tagged posts.' do
  before do
    create(:post)
    create(:post)
    create(:post, tag: Tag.first)
    create(:post, tag: Tag.first)
    create(:post)
    visit root_path
  end

  context 'user visits root path' do
    scenario 'user can click on tag to filter results solely by that tag' do
      expect(page).to have_content(Tag.first.name)
      first(".post").first(".tag").click
      expect(page).to have_selector(".post", count: 3)
    end
  end

  context 'user visits show page' do
    scenario 'user can click on tag from show page to filter results solely by that tag' do
      visit post_path(Post.first)
      first(".tag").click
      expect(page).to have_selector(".post", count: 3)
    end
  end
end
