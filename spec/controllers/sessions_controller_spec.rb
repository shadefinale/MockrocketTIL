require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context '#create' do
    let(:a) { create(:author, password: "abcd1234", password_confirmation: "abcd1234") }
    it 'should redirect to root path on successful sign in' do
      expect(post :create, username: a.username, password: "abcd1234").to redirect_to(root_path)
    end
    it 'should redirect to new author path on failed sign in' do
      expect(post :create, username: a.username, password: "abcd123").to redirect_to(new_author_path)
    end

    it 'should sign in user on successful sign in' do
      post :create, username: a.username, password: "abcd1234"
      expect(assigns(:current_user)).to eq(a)
    end
  end

  context '#destroy' do
    it 'should redirect to root path after sign out' do
      expect(post :destroy).to redirect_to(root_path)
    end

    it 'should set current_user to nil during sign out' do
      current_user = build(:author)
      post :destroy
      expect(assigns(:current_user)).to be_nil
    end
  end
end
