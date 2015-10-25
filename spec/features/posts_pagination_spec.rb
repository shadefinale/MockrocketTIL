require 'rails_helper'

feature 'As a user, I want to have paginated posts so that I am not initially overwhelmed by loading times and the sheer amount of information.' do
  context 'user vists root path' do
    before do
      50.times do
        create(:post)
      end
      visit root_path
    end

    scenario 'posts are paginated' do
      # Mac visits the site and sees that there are 30 posts with a button to go
      # to the next post.
      expect(page).to have_css('.post', count: 30)
      expect(page).to have_css('.prev.disabled')

      # Mac clicks on the button to go to the next page, and sees 20 more
      # posts.
      click_link("Next")
      expect(page).to have_css('.post', count: 20)

      # Seeing that there is no next page button, Mac decides to return by
      # clicking the 'back' button.
      expect(page).to have_css('.next.disabled')
      click_link('Prev')

      # Mac finds himself back where he started.
      expect(page).to have_css('.post', count: 30)
      expect(page).to have_css('.prev.disabled')
    end
  end
end
