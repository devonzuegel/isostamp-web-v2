describe SessionsController, :omniauth do
  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe 'routes' do
    it 'routes to #create' do
      expect(get: '/auth/facebook/callback').to route_to('sessions#create', provider: 'facebook')
      expect(get: '/auth/twitter/callback').to  route_to('sessions#create', provider: 'twitter')
    end

    it 'routes to #new' do
      expect(get: '/signin').to route_to('sessions#new')
    end

    it 'routes to #destroy' do
      expect(get: '/signout').to route_to('sessions#destroy')
    end

    it 'routes to #failure' do
      expect(get: '/auth/failure').to route_to('sessions#failure')
    end
  end

  describe '#create' do
    it 'creates a user' do
      expect { post :create, provider: :facebook }.to change { User.count }.by(1)
    end

    it 'creates a session' do
      original_session_count = Session.count
      expect(session[:user_id]).to be_nil
      post :create, provider: :facebook
      expect(session[:user_id]).not_to be_nil
      expect(Session.count).to eq(original_session_count + 1)
    end

    it 'redirects to the home page' do
      post :create, provider: :facebook
      expect(response).to redirect_to root_url
    end
  end

  describe '#destroy' do
    before do
      post :create, provider: :facebook
    end

    it 'resets the session' do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the home page' do
      delete :destroy
      expect(response).to redirect_to root_url
    end
  end
end
