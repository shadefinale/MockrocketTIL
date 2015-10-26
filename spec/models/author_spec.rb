require 'rails_helper'

RSpec.describe Author, type: :model do
  context '::by_posts' do
    before do
      3.times do |idx|
        new_author = create(:author)
        idx + 1.times do
          new_author.posts << create(:post, author: new_author)
        end
      end
    end

    it 'should return tags in order of number of posts' do
      expect(Author.by_posts).to match_array([Author.third, Author.second, Author.first])
    end
  end
end
