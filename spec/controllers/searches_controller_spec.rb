require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  context '#show' do
    let!(:post1) { create(:post, body: "test hello world foo bar") }
    let!(:post2) { create(:post, body: "test hell world") }
    let!(:post3) { create(:post, body: "test hello world") }
    let!(:post4) { create(:post, body: "test HELLO WORLD") }

    it 'should show all posts if no :search parameter' do
      get :show
      expect(assigns(:posts)).to match_array([post1, post2, post3, post4])
    end

    it 'should show only posts that match :search parameter' do
      get :show, search: 'foo'
      expect(assigns(:posts)).to match_array([post1])
    end

    it 'should match :search parameter case insensitive' do
      get :show, search: 'hello'
      expect(assigns(:posts)).to match_array([post1, post3, post4])
    end
  end

end
