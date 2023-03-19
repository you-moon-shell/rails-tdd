require 'rails_helper'

RSpec.describe 'Articles', type: :routing do
  describe '/articles' do
    it 'routes /articles to the articles#index' do
      expect(get '/articles').to route_to('articles#index')
    end
    it 'routes /articles/1 to the articles#show' do
      expect(get '/articles/1').to route_to('articles#show', id: '1')
    end
  end
end
