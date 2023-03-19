require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe '#index' do
    subject { get '/articles' }
    it 'returns a 200' do
      subject
      expect(response).to have_http_status(:ok)
    end
    it 'returns articles in json format' do
      FactoryBot.reload
      articles = create_list :article, 1
      subject
      expect(json_data.length).to eq(1)
      articles.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug,
        })
      end
    end
    it 'returns articles sorted by newest to oldest' do
      FactoryBot.reload
      article = create :article
      newer_article = create :article
      subject
      expect(json_data.first['id']).to eq(newer_article.id.to_s)
      expect(json_data.last['id']).to eq(article.id.to_s)
    end
    it 'returns articles pagenated by given conditions' do
      FactoryBot.reload
      create_list :article, 3
      get '/articles', params: { page: 2, per: 1 }
      expect(json_data.length).to eq(1)
      expected_article = Article.recent.second
      expect(json_data.first['id']).to eq(expected_article.id.to_s)
    end
  end
end
