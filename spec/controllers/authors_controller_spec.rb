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

    it 'should return all posts if author does not exist' do
      get :show, id: 'abc123yeah'
      expect(assigns(:posts)).to match_array([post1, post2, post3])
    end
  end

  context '#new' do
    it 'should assign a new author' do
      get :new
      expect(assigns(:author)).to be_a(Author)
    end
  end

  context '#create' do
    it 'should create a new author if valid' do
      expect do
        post :create, author: attributes_for(:author)
      end.to change(Author, :count).by(1)
    end

    it 'should sign in the user if valid' do
      post(:create, author: attributes_for(:author))
      expect(assigns(:current_user)).to_not be_nil
    end

    context 'username validations' do
      it 'should not create an author if missing username' do
        expect do
          post :create, author: attributes_for(:author, username: nil)
        end.to change(Author, :count).by(0)
      end

      it 'should not create an author if wrong format' do
        expect do
          post :create, author: attributes_for(:author, username: "awesome guy")
        end.to change(Author, :count).by(0)
      end

      it 'should not create a new author if invalid username (too short)' do
        expect do
          post :create, author: attributes_for(:author, username: "a" * 5)
        end.to change(Author, :count).by(0)
      end

      it 'should not create a new author if invalid username (too long)' do
        expect do
          post :create, author: attributes_for(:author, username: "a" * 25)
        end.to change(Author, :count).by(0)
      end
    end

    context 'password validations' do
      it 'should not create a new author if invalid password (too short)' do
        expect do
          post :create, author: attributes_for(:author,
                                               password: "abcd123",
                                               password_confirmation: "abcd123")
        end.to change(Author, :count).by(0)
      end

      it 'should not create a new author if invalid password (too long)' do
        expect do
          post :create, author: attributes_for(:author,
                                               password: "a" * 65,
                                               password_confirmation: "a" * 65)
        end.to change(Author, :count).by(0)
      end

      it 'should not create a new author if mismatched password' do
        expect do
          post :create, author: attributes_for(:author, password: "aaaa1111")
        end.to change(Author, :count).by(0)
      end
    end
  end

end
