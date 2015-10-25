require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '#update' do
    let(:post) { create(:post) }

    it 'should increment the likes counter of a post if not already liked' do
     expect do
       put :update, id: post.id
       post.reload
     end.to change{post.likes}.by(1)
    end

    it 'should unlike a post if called again after liking' do
     expect do
       put :update, id: post.id
       put :update, id: post.id
       post.reload
     end.to change{post.likes}.by(0)
    end

    it 'should redirect to root_path if post does not exist' do
      expect(put :update, id: post.id + 1).to redirect_to(root_path)
    end

    it 'should redirect to root_path if post does not exist even if there is a :back' do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      expect(put :update, id: post.id + 1).to redirect_to(root_path)
    end

    it 'should redirect to root_path if they have no :back for whatever reason' do
      expect(put :update, id: post.id).to redirect_to(root_path)
    end

    it 'should redirect back to wherever they came from' do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      expect(put :update, id: post.id).to redirect_to("where_i_came_from")
    end
  end

end
