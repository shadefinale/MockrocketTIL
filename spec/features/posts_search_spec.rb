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
      first('#search').click

      expect(current_path).to eq(search_path)

    end

  end


end
