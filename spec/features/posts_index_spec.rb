require 'rails_helper'

feature 'As a user, I want to be able to see a list of posts so that I can learn more things today' do
  context 'user vists root path' do
    before do
      create(:post, title: "Test Post", body: "Lorem Ipsum", created_at: "2014-10-10")
      create(:post, created_at: "2014-9-9")
      visit root_path
    end

    scenario 'user sees multiple posts' do
      expect(page).to have_css('.post', count: 2)
      expect(first('.post')).to have_content("Test Post")
      expect(first('.post')).to have_content("Lorem Ipsum")
    end

    scenario 'user can click on post to go to show page' do
      click_link(Post.last.title)
      expect(current_path).to eq(post_path(Post.last))
    end

    scenario 'user can see date of posts on index page' do
      expect(page).to have_content("October 10, 2014")
    end

  end


end
