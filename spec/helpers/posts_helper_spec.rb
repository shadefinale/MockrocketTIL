require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let!(:post1) { create(:post) }
  let!(:post2) { create(:post) }

  context '#next_button' do
    it 'should return a link_to if there is a next post' do
      expect(next_button(post1)).to eq(link_to("Next Post", post2))
    end

    it 'should return a nil if there is not a next post' do
      expect(next_button(post2)).to be_nil
    end
  end

  context '#prev_button' do
    it 'should return a link_to if there is a previous post' do
      expect(prev_button(post2)).to eq(link_to("Previous Post", post1))
    end

    it 'should return a nil if there is not a next post' do
      expect(prev_button(post1)).to be_nil
    end
  end

  context '#raw_link' do
    it 'should return a link_to the post with raw format' do
      expect(raw_link(post1)).to eq(link_to("View Raw", post_path(post1, format: :text)))
    end
  end

  context '#tag_link' do
    it 'should return a link_to the posts_path along with the tag_id' do
      expect(tag_link(post1)).to eq(link_to("#{post1.tag.name}", posts_path(tag_id: post1.tag.id), class: "tag"))
    end
  end

  context '#author_link' do
    it 'should_return a link_to the author_path of the post author' do
      expect(author_link(post1)).to eq(link_to("By #{post1.author.username}", author_path(post1.author), class: "author"))
    end
  end
end
