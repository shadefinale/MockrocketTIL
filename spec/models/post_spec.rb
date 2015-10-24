require 'rails_helper'

RSpec.describe Post, type: :model do
  context '#publish_date' do
    it 'should return creation date in human readable format' do
      post = create(:post, created_at: "2015-10-23 01:00:00")
      expect(post.publish_date).to eq("October 23, 2015")
    end
  end
end

