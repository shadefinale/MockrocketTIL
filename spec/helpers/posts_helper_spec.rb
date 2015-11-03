require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let!(:post1) { create(:post) }
  let!(:post2) { create(:post, likes: 1) }

  context '#next_button' do
    it 'should return a link_to if there is a next post' do
      expect(next_button(post1)).to eq(link_to("Next Post", post2, class: "btn btn-success"))
    end

    it 'should return a nil if there is not a next post' do
      expect(next_button(post2)).to be_nil
    end
  end

  context '#prev_button' do
    it 'should return a link_to if there is a previous post' do
      expect(prev_button(post2)).to eq(link_to("Previous Post", post1, class: "btn btn-danger"))
    end

    it 'should return a nil if there is not a next post' do
      expect(prev_button(post1)).to be_nil
    end
  end

  context '#raw_link' do
    it 'should return a link_to the post with raw format' do
      expect(raw_link(post1)).to eq(link_to("View Raw", post_path(post1, format: :text), class: "btn btn-success"))
    end
  end

  context '#tag_link' do
    it 'should return nil if post has no tag' do
      post2.tag = nil
      expect(tag_link(post2)).to be_nil
    end
    it 'should return a link_to the posts_path along with the tag_id' do
      expect(tag_link(post1)).to eq(link_to("#{post1.tag.name}", posts_path(tag_id: post1.tag.id), class: "tag"))
    end
  end

  context '#author_link' do
    it 'should_return a link_to the author_path of the post author' do
      expect(author_link(post1)).to eq(link_to("By #{post1.author.username}", author_path(post1.author), class: "author"))
    end
  end

  context '#likes_count' do
    it 'should display the proper amount of likes to the user when not one like' do
      expect(likes_count(post1)).to eq("0 likes")
    end

    it 'should display the proper amount of likes to the user when one like' do
      expect(likes_count(post2)).to eq("1 like")
    end
  end

  context '#like_button' do
    it 'should give us a clickable link to like a post' do
      session[:liked] = {}
      expect(like_button(post1)).to eq(link_to("0 likes (Like)", like_path(post1), method: "PUT", remote: true, data: {id: post1.id}, class: "like btn btn-info"))
    end

    it 'should give us a clickable link to unlike a post' do
      session[:liked] = {post2.id => true}
      expect(like_button(post2)).to eq(link_to("1 like (Unlike)", like_path(post2), method: "PUT", remote: true, data: {id: post2.id}, class: "like btn btn-info"))
    end
  end

  context '#like_action' do
    it 'should say "Like" if post is not liked already' do
      session[:liked] = {}
      expect(like_action(post1)).to eq("(Like)")
    end

    it 'should say "Unlike" if post is not liked already' do
      session[:liked] = {post1.id => true}
      expect(like_action(post1)).to eq("(Unlike)")
    end
  end

  context '#new_post_button' do
    it 'should link to new_post_path if current_user author' do
      author = create(:author)
      current_user = author
      expect(new_post_button(current_user, author.id)).to eq(link_to("Create Post", new_post_path, class: "btn btn-info"))
    end

    it 'should not link to new_post_path if current_user is not author' do
      author = create(:author)
      current_user = build(:author)
      expect(new_post_button(current_user, author.id)).to be_nil
    end
  end
end
