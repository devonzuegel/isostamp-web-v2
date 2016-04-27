describe DocumentsController, :omniauth do
  let(:user) { create(:user) }


  describe '/documents => :index' do

    it 'should redirect to root if user not signed in' do
      get :index
      assert_response :redirect
      assert_redirected_to root_url
    end

    it 'should retrieve the user\'s documents' do
      2.times { create(:document, user: user) }

      session[:user_id] = user

      get :index

      expect(assigns(:document)).to_not be_nil

      expect(Document.in_progress(user).count).to    be 2
      expect(assigns(:uploading_docs).length).to eq 2
      expect(Document.in_progress(user).map(&:id)).to match assigns(:uploading_docs).map(&:id)

      expect(Document.done_uploading(user).count).to be 0
      expect(assigns(:completed_docs).length).to eq 0
      expect(Document.done_uploading(user).map(&:id)).to match assigns(:completed_docs).map(&:id)
    end
  end
end