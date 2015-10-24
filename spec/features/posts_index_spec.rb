require 'rails_helper'

feature 'As a user, I want to be able to see a list of posts so that I can learn more things today' do
  context 'user vists root path' do
    before do
      visit root_path
    end

    scenario 'user sees multiple posts' do
      expect(page).to have_css('.post', count: 2)
    end
  end


end
