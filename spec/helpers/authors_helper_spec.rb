require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AuthorsHelper. For example:
#
# describe AuthorsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AuthorsHelper, type: :helper do
  describe '#field_with_errors' do
    it 'should be empty if no errors' do
      a = build(:author)
      a.valid?

      expect(field_with_errors(a, :username).length).to eq(0)
    end

    it 'should be empty if no errors' do
      a = build(:author, username: "abc12")
      a.valid?

      expect(field_with_errors(a, :username)).to eq(
        content_tag(:div, class: "error") { :username.to_s.titleize + " " + a.errors[:username].first }
      )
    end

  end
end
