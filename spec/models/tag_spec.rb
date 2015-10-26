require 'rails_helper'

RSpec.describe Tag, type: :model do
  context '::by_posts' do
    before do
      3.times do |idx|
        new_tag = create(:tag)
        idx + 1.times do
          new_tag.posts << create(:post, tag: new_tag)
        end
      end
    end

    it 'should return tags in order of number of posts' do
      expect(Tag.by_posts).to match_array([Tag.third, Tag.second, Tag.first])
    end
  end
end
