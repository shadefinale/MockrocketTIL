require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
end
