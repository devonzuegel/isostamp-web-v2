describe DocumentsController, :omniauth do
  describe 'retrieving a nonexistent document' do
    it 'should give a 404'
  end

  describe 'retrieving a document' do
    it 'should succeed if it is owned by the current user'
    it 'should fail if it is not owned by the current user'
  end
end