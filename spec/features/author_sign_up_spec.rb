require 'rails_helper'

feature 'As an author, I want to be able to sign up to use the site so that I can use the site and generate content' do
  before do
    visit root_path
  end

  scenario 'the main page should have a button to sign in/up' do
    expect(page).to have_content("Sign In/Up")
  end

  context 'signing up to the site' do
    before do
      click_link("Sign In/Up")
    end

    scenario 'signing up with valid information' do
      fill_out_signup_form
      expect{click_button "Sign Up"}.to change(Author, :count).by(1)
      expect(current_path).to eq(root_path)
    end

    scenario 'signing up invalid username' do
      fill_out_signup_form(username: "test user")
      expect{click_button "Sign Up"}.to change(Author, :count).by(0)
    end

    scenario 'signing up invalid password' do
      fill_out_signup_form(password: "abcd123", password_confirmation: "abcd123")
      expect{click_button "Sign Up"}.to change(Author, :count).by(0)
    end

    scenario 'signing up mismatch password and password confirm' do
      fill_out_signup_form(password: "abcd1234", password_confirmation: "abcd1235")
      expect{click_button "Sign Up"}.to change(Author, :count).by(0)
    end
  end
end
