require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username) }
    it { is_expected.to validate_length_of(:password) }

    it 'should be valid' do
      expect(build(:author)).to be_valid
    end

    it 'should not be valid if wrong format (spaces)' do
      expect(build(:author, username: 'the bestest')).to_not be_valid
    end

    it 'should not be valid if wrong format (dashes)' do
      expect(build(:author, username: 'the-bestest')).to_not be_valid
    end

  end

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
