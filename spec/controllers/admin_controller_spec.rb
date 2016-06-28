describe AdminController, :omniauth do
  describe 'routes' do

    it 'routes to #index' do
      expect(get: '/admin').to route_to('admin#index')
    end

    it 'routes to #documents' do
      expect(get: '/admin/documents').to route_to('admin#documents')
    end

    it 'routes to #executions' do
      expect(get: '/admin/executions').to route_to('admin#executions')
    end

  end
end