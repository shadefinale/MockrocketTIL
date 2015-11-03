require 'rails_helper'

feature 'As a user, I want to be able to click the "like" button so that I can show how much I like the post.' do
  context 'user viewing likes' do
    before do
      create(:post, likes: 3, created_at: "2014-10-10")
      create(:post, likes: 1, created_at: "2014-9-9")
    end

    scenario 'user on root path' do
      # Bob is a new user and he visits the root path.
      visit root_path

      # Bob sees a post and can also see that it has three likes.
      expect(first(".post")).to have_content("3 likes")
    end

    scenario 'user on show page' do
      # Bob remembers the post from before and visits its show page
      visit post_path(Post.last)

      # He sees that this post has only 1 like.
      expect(first(".post")).to have_content("1 like")
      expect(first(".post")).to_not have_content("1 likes")
    end
  end

  context 'user liking and unliking posts' do
    before do
      @post1 = create(:post, created_at: "2014-10-10")
      @post2 = create(:post, likes: 3, created_at: "2014-9-9")
    end
    scenario 'user interacting with site' do
      # Bob visits the site again and looks at the posts index
      visit root_path

      # Bob sees a post and he likes it, so he clicks on the `like` link
      first(".post").first(".like").click

      # Bob remains on the index page after clicking
      expect(current_path).to eq(root_path)

      # Then, Bob expects a post to now have one like.
      expect(page).to have_content("1 like")

      # Bob then visits the show page for this post, and sees that his like has
      # persisted.

      # We have to set the session variable here to not interrupt the above
      # expectations.
      page.set_rack_session(:liked => {@post1.id.to_s => true})

      visit post_path(@post1)
      expect(first(".post")).to have_content("1 like")

      # Bob re-reads the post and unfortunately decides he just doesn't like it
      # anymore. He sees that there is an option to unlike,
      # then clicks to unlike the post.
      expect(first(".post")).to have_content("Unlike")
      first(".post").first(".like").click

      # Bob does not get returned to the index path, but is still on the
      # show page for this individual post
      expect(current_path).to eq(post_path(Post.first))

      # Bob then expects the first post to now have no likes again.
      expect(first(".post")).to have_content("0 likes")
    end
  end
end
