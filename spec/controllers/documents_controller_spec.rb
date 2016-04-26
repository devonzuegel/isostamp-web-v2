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
      expect(assigns(:documents)).to match Document.where(user: user)
      expect(assigns(:documents).length).to eq 2
    end
  end
end