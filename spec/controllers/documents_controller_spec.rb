describe DocumentsController, :omniauth do
  let(:user) { create(:user) }

  describe '/documents => :index' do
    it 'redirects to root if user not signed in' do
      get :index
      assert_response :redirect
      assert_redirected_to root_url
    end

    it 'retrieves the user\'s documents' do
      2.times { create(:document, user: user) }
      session[:user_id] = user

      get :index

      expect(assigns(:documents).length).to eq 2
    end
  end

  describe 'routes' do
    let(:doc) { create(:document, user: user) }

    it 'routes to #index' do
      expect(get: '/documents').to route_to('documents#index')
    end

    it 'routes to #create' do
      expect(post: '/documents').to route_to('documents#create')
    end

    it 'routes to #destroy' do
      expect(delete: "/documents/#{doc.id}").to route_to('documents#destroy', id: doc.id.to_s)
    end
  end
end
