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
        expect(assigns(:post)).to eq(post) end

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

  context 'post creation' do
    let(:author) { create(:author) }


    context '#new' do

      it 'should redirect to root path if not logged in' do
        allow(controller).to receive(:current_user) { false }
        expect(get :new).to redirect_to(root_path)
      end

      it 'should assign a new post to current author' do
        allow(controller).to receive(:current_user) { author }
        get :new
        expect(assigns(:post)).to_not be_nil
      end
    end

    context '#create' do
      it 'should create a new post belonging to current_user' do
        allow(controller).to receive(:current_user) { author }
        new_post = build(:post)
        new_post_attrs = new_post.attributes
        new_post_attrs[:tag_attributes] = {name: "test"}
        post :create, post: new_post_attrs
        expect(Post.last.title).to eq(new_post.title)
        expect(Post.last.body).to eq(new_post.body)
        expect(Post.last.author).to eq(author)
      end

      it 'should not create a post if no current user' do
        new_post = build(:post)
        new_post_attrs = new_post.attributes
        new_post_attrs[:tag] = "Ruby"
        expect do
          post :create, post: new_post_attrs
        end.to change(Post, :count).by(0)
      end

      context 'length validations' do
        before do
          allow(controller).to receive(:current_user) { author }
        end

        it 'should not create a post if invalid title length' do
          new_post = build(:post, title: 'aa')
          new_post_attrs = new_post.attributes
          new_post_attrs[:tag] = "Ruby"
          expect do
            post :create, post: new_post_attrs
          end.to change(Post, :count).by(0)
        end

        it 'should not create a post if invalid body length' do
          new_post = build(:post, body: 'abbaa ' * 202)
          new_post_attrs = new_post.attributes
          new_post_attrs[:tag] = "Ruby"
          expect do
            post :create, post: new_post_attrs
          end.to change(Post, :count).by(0)
        end

      end

    end
  end

  context '#destroy' do
    let!(:author) { create(:author) }
    let!(:other_author) { create(:author) }
    let!(:test_post) { create(:post, author: author) }
    it 'should destroy a post of owner' do
      allow(controller).to receive(:current_user) { author }
      expect do
        delete :destroy, id: test_post.id
      end.to change(Post, :count).by(-1)
    end

    it 'should not destroy a post if not owner' do
      allow(controller).to receive(:current_user) { other_author }
      expect do
        delete :destroy, id: test_post.id
      end.to change(Post, :count).by(0)
    end
  end

  context '#edit' do
    let!(:author) { create(:author) }
    let!(:other_author) { create(:author) }
    let!(:test_post) { create(:post, author: author) }

    context 'author logged in' do
      before do
        allow(controller).to receive(:current_user) { author }
      end

      it 'should find a post if it exists' do
        get :edit, id: test_post.id
        expect(assigns(:post)).to eq(test_post)
      end

      it 'should redirect to posts path if post is not found' do
        expect(get :edit, id: test_post.id + 1).to redirect_to(root_path)
      end

      it 'should redirect to posts path if not owner' do
        allow(controller).to receive(:current_user) { other_author }
        expect(get :edit, id: test_post.id).to redirect_to(root_path)
      end

    end

    it 'should redirect if no author' do
      expect(get :edit, id: test_post.id).to redirect_to(root_path)
    end
  end
end
