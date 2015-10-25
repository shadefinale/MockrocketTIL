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

    context 'html requests' do
      it 'should return a given post' do
        get :show, id: post.id
        expect(assigns(:post)).to eq(post)
      end

      it 'should redirect to posts index if post does not exist' do
        expect(get :show, id: post.id + 1).to redirect_to(posts_path)
      end
    end

    context 'text requests' do
      it 'should return the given post body' do
        get :show, id: post.id, format: :text
        expect(response.body).to eq(post.body)
      end

      it 'should return a failure string if there is no post by given id' do
        get :show, id: post.id + 1, format: :text
        expect(response.body).to eq("Post not found.")
      end
    end
  end

end
