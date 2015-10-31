require 'rails_helper'

feature 'As a user, I want to be able to create a post so that I can tell people what I learned ' do

  before do
    @author = create(:author, password: "abcd1234", password_confirmation: "abcd1234")
    @other_author = create(:author)
    visit new_author_path
    fill_out_signin_form(username: @author.username, password: "abcd1234")
    click_button("Sign In")
  end

  it 'should display a "Create Post" button on own show page' do
    visit author_path(@author)
    expect(page).to have_content("Create Post")
  end

  it 'should not display a "Create Post" on other user show page' do
    visit author_path(@other_author)
    expect(page).to_not have_content("Create Post")
  end

end
