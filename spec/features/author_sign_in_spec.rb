require 'rails_helper'

feature 'As an author, I want to be able to sign in to use the site so that I can use the site and generate content' do
  before do
    @author_password = "abcd1234"
    @author = create(:author, username: "test_user", password: @author_password, password_confirmation: @author_password)
  end

  context 'signing into the site' do
    before do
      visit root_path
      click_link("Sign In/Up")
    end

    scenario 'signing in with valid information' do
      fill_out_signin_form(username: @author.username, password: @author_password)
      click_button('Sign In')
      expect(current_path).to eq(root_path)
      expect(current_auth_token).to_not be_nil
      expect(page).to_not have_content("Sign In/Up")
    end

    scenario 'signing invalid username/password combo' do
      fill_out_signin_form(username: @author.username, password: "blah")
      click_button('Sign In')
      expect(current_path).to eq(new_author_path)
    end
  end

  context 'signing out' do
    scenario 'signing out of the site after logging in' do
      visit new_author_path
      fill_out_signin_form(username: @author.username, password: @author_password)
      click_button('Sign In')
      click_link("Sign Out")
      expect(current_path).to eq(root_path)
      expect(current_auth_token).to be_nil
    end
  end
end

