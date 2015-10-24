require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context '#index' do
    let(:post1) { create(:post) }
    let(:post2) { create(:post) }

    it 'should return all posts' do
      get :index
      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end


  context '#show' do
    let(:post) { create(:post) }

    it 'should return a given post' do
      get :show, id: post.id
      expect(assigns(:post)).to eq(post)
    end

    it 'should raise an error if post does not exist' do
      expect do
        get :show, id: post.id + 1
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
