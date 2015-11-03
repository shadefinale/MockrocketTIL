require 'rails_helper'

feature 'As a user, I want to be able to edit a post so that I can tell people what I learned more effectively' do

  before do
    @author = create(:author, password: "abcd1234", password_confirmation: "abcd1234")
    @other_author = create(:author)
    visit new_author_path
    fill_out_signin_form(username: @author.username, password: "abcd1234")
    click_button("Sign In")
  end

  scenario 'author can see edit creation button on show page' do
    p = create(:post, author: @author)
    visit post_path(p)

    expect(page).to have_content("Edit Post")
  end

  scenario 'author wants to edit post' do
    p = create(:post, author: @author)
    # Guy wants to create a post, so after logging in he looks at his posts.
    visit author_path(@author)

    # Guy sees that there is a button available to allow him to edit a post,
    # and he clicks it.
    expect(page).to have_content("Edit Post")
    click_link("Edit Post")

    # Guy sees that he's on a page to edit a post.
    expect(current_path).to eq(edit_post_path(p))

    # Guy also sees the previous contents of the post.
    expect(page).to have_selector("input[value='" + p.title + "']")
    expect(page).to have_selector("input[value='" + p.tag.name + "']")
    # Then, Guy edits the post's title.
    fill_in("Title", with: "New Title")

    # After that, Guy saves the post.
    click_button("Save Post")

    # Guy sees that he's brought to the post itself, but he wants
    # now to show it to his friend by going to the root path.

    expect(current_path).to eq(post_path(Post.last))
    visit root_path

    # Guy sees that his post is the very first one since it is the newest.
    expect(page).to have_content("New Title")
  end

  scenario 'author creates multiple posts with different tags' do
    # Tak wants to make a bunch of posts with different tags.
    # He creates a bunch of posts

    create_post

    create_post

    create_post(tag_name: "Rubie")
    create_post(tag_name: "Rubie")
    create_post(tag_name: "Rubie")

    # Then, Tak goes to the author path and sees that he has 5 posts
    visit author_path(@author)
    expect(page).to have_css(".post", count: 5)

    # After that, Tak clicks on one of the posts tagged 'Rubie'
    # and sees that there are 3 posts by this tag
    click_link("Rubie", match: :first)
    expect(page).to have_css(".post", count: 3)
  end

  scenario 'author creates invalid posts' do
    # Post should not be valid with short title, and error message displayed.
    create_post(title: 'ab')
    expect(page).to have_content("between 3 and 64")

    # Post should not be valid with long body, and error message displayed.
    create_post(body: 'abcd ' * 201)
    expect(page).to have_content("between 1 and 200")

    # Posts should not persist if visiting index
    visit root_path
    expect(page).to_not have_css(".post")
  end

  scenario 'should not display a "Create Post" on other user show page' do
    visit author_path(@other_author)
    expect(page).to_not have_content("Create Post")
  end

  scenario 'should not display a "Create Post" on show page of non authored post' do
    p = create(:post, author: @other_author)
    expect(page).to_not have_content("Create Post")
  end

  scenario 'should not be able to access post creation path if not logged in' do
    click_link('Sign Out')
    visit new_post_path
    expect(current_path).to eq(root_path)
  end


end
