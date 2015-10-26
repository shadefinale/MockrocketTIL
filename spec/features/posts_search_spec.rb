require 'rails_helper'

feature 'As a user, I want to be able to search post bodies so that I can find information faster.' do
  context 'user performs searches' do
    before do
      create(:post, body: "test hello world foo bar")
      create(:post, body: "test hell world")
      create(:post, body: "test hello world")
      create(:post, body: "test HELLO WORLD")
    end

    scenario 'user performs different searches' do
      visit root_path
      # User can visit search path from root path
      first('#search').click
      expect(current_path).to eq(search_path)

      # User can fill out form and match text
      fill_in('Search', :with => 'test')
      first('#search_button').click
      expect(page).to have_css('.post', count: 4)

      # User can fill out form again since search results
      # are on the same view as the search form
      # Search does not just return all matches
      fill_in('Search', :with => 'hello')
      first('#search_button').click
      expect(page).to have_css('.post', count: 3)

      # More search testing
      fill_in('Search', :with => 'foo bar')
      first('#search_button').click
      expect(page).to have_css('.post', count: 1)

      # Search returns 0 results if no matches.
      fill_in('Search', :with => 'asdf')
      first('#search_button').click
      expect(page).to have_css('.post', count: 0)
    end
  end
end
