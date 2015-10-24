require 'rails_helper'

RSpec.describe Post, type: :model do
  context '#publish_date' do
    it 'should return creation date in human readable format' do
      post = create(:post, created_at: "2015-10-23 01:00:00")
      expect(post.publish_date).to eq("October 23, 2015")
    end
  end

  context '#previous/next' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }
    let!(:post3) { create(:post) }

    context '#previous' do
      it 'should return the previous post (and previous post exists)' do
        expect(post2.previous).to eq(post1)
      end

      it 'should return nil(previous post does not exist)' do
        expect(post1.previous).to be_nil
      end

      it 'should return the previous post that is closest to this post' do
        expect(post3.previous).to eq(post2)
      end
    end

    context '#next' do
      it 'should return the next post (and next post exists)' do
        expect(post2.next).to eq(post3)
      end

      it 'should return nil(next post does not exist)' do
        expect(post3.next).to be_nil
      end
    end
  end
end

