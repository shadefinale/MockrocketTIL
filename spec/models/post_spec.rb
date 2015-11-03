require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to validate_length_of(:body) }

    it 'should be valid' do
      expect(build(:post)).to be_valid
    end

  end

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

  context '#increment_likes' do
    let(:post1) { create(:post) }
    it 'should increase the amount of likes on the post by 1' do
      expect{post1.increment_likes}.to change{post1.likes}.by(1)
    end
  end

  context '#decrement_likes' do
    let(:post1) { create(:post, likes: 5) }
    let(:post2) { create(:post) }
    it 'should decrease the amount of likes on the post by 1' do
      expect{post1.increment_likes}.to change{post1.likes}.by(1)
    end

    it 'should not decrease the amount of likes on the post if already at 0' do
      expect{post2.decrement_likes}.to change{post2.likes}.by(0)
    end
  end

  context '::most_liked' do
    before do
      15.times do |idx|
        create(:post, likes: idx)
      end
    end

    it 'should return 10 posts' do
      expect(Post.most_liked.length).to be <= 10
    end

    it 'should return posts in descending order' do
      most_liked_posts = Post.most_liked
      expect(most_liked_posts.order(likes: :desc)).to eq(most_liked_posts)
    end
  end

  context '::by_day' do
    before do
      30.times do |idx|
        create(:post, created_at: DateTime.now - idx.day)
      end
    end

    it 'should return a result where every day has one post' do
      expect(Post.by_day.values).to all( be > 0)
    end
  end

  context '::search' do
    before do
      create(:post, body: 'testy')
      create(:post, body: 'test')
      create(:post, body: 'TESTER')
    end

    it 'should return even partial matches' do
      expect(Post.search('test').length).to eq(3)
    end

    it 'should match case insensitive' do
      expect(Post.search('tester').length).to eq(1)
    end

    it 'should return empty collection if no matches' do
      expect(Post.search('asdafsdf').length).to eq(0)
    end
  end
end

