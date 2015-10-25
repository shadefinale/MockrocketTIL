require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  let(:author) { create(:author) }
  let!(:post1) { create(:post, author: author) }
  let!(:post2) { create(:post) }
  let!(:post3) { create(:post, author: author) }

  context '#show' do
    it 'should show all posts by a given author' do
      get :show, id: author.id
      expect(assigns(:posts)).to match_array([post1, post3])
    end
  end

end
