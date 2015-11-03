require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  describe 'sign_in_or_out_link' do
    it 'should show sign out if no current user' do
      expect(sign_in_or_out_link(true)).to eq(link_to('Sign Out', sessions_path, method: "DELETE", class: 'btn btn-default'))
    end

    it 'should show sign in/up if no current user' do
      expect(sign_in_or_out_link(false)).to eq(link_to('Sign In/Up', new_author_path, class: 'btn btn-default'))
    end
  end
end
