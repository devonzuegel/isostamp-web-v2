describe UsersController, :omniauth do
  let(:user) { create(:user) }

  describe 'routes' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #update' do
      expect(put: "/users/#{user.id}").to route_to('users#update', id: user.id.to_s)
    end

    it 'routes to #update' do
      expect(patch: "/users/#{user.id}").to route_to('users#update', id: user.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}").to route_to('users#destroy', id: user.id.to_s)
    end
  end
end
