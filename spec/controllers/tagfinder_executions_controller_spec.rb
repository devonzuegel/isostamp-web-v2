describe TagfinderExecutionsController, :omniauth do
  let(:execution) { create(:tagfinder_execution) }

  describe 'routes' do
    it 'routes to #index' do
      expect(get:   '/run/').to route_to 'tagfinder_executions#index'
    end

    it 'routes to #create' do
      expect(post:  '/run/').to route_to 'tagfinder_executions#create'
    end

    it 'routes to #show' do
      expect(get:   "/run/#{execution.id}").to route_to 'tagfinder_executions#show', id: execution.id.to_s
    end

    it 'routes to #update' do
      expect(patch: "/run/#{execution.id}").to route_to 'tagfinder_executions#update', id: execution.id.to_s
    end

    it 'routes to #update' do
      expect(put:   "/run/#{execution.id}").to route_to 'tagfinder_executions#update', id: execution.id.to_s
    end
  end
end
