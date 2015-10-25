require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context '#index' do

    context 'non-pagination' do
      let(:tag)   { create(:tag) }
      let!(:post1) { create(:post, tag: tag) }
      let!(:post2) { create(:post) }
      let!(:post3) { create(:post, tag: tag) }

      it 'should return all posts' do
        get :index
        expect(assigns(:posts)).to match_array([post1, post2, post3])
      end

      it 'should return posts filtered by tag if a tag_id is provided' do
        get :index, tag_id: tag.id
        expect(assigns(:posts)).to match_array([post1, post3])
      end

      it 'should just return all posts if tag_id is nonsensical' do
        get :index, tag_id: 'asdlfkjsdflj'
        expect(assigns(:posts)).to match_array([post1, post2, post3])
      end
    end

    context 'pagination' do
      before do
        create_list(:post, 50)
      end

      it 'should return 30 results if no page passed' do
        get :index, page: nil
        expect(assigns(:posts).length).to eq(30)
      end

      it 'should return remaining results if not enough for full page' do
        get :index, page: '2'
        expect(assigns(:posts).length).to eq(20)
      end
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
