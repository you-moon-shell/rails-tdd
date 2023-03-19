require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with valid attributes' do
    article = build :article
    expect(article).to be_valid
  end
  it 'is not valid without a title' do
    article = build :article, title: ''
    expect(article).not_to be_valid
    expect(article.errors.messages[:title]).to include("can't be blank")
  end
  it 'is not valid without a content' do
    article = build :article, content: ''
    expect(article).not_to be_valid
    expect(article.errors.messages[:content]).to include("can't be blank")
  end
  it 'is not valid without a slug' do
    article = build :article, slug: ''
    expect(article).not_to be_valid
    expect(article.errors.messages[:slug]).to include("can't be blank")
  end
  it 'is not valid with a duplicated slug' do
    article = create :article
    duplicated_article = build :article, slug: article.slug
    expect(duplicated_article).not_to be_valid
  end
  describe '#recent' do
    it 'returns articles sorted by newest to oldest' do
      article = create :article
      newer_article = create :article
      expect(described_class.recent).to eq([newer_article, article])
    end
    context 'when a article is updated' do
      it 'returns articles sorted by newest to oldest' do
        article = create :article
        newer_article = create :article
        article.update_column :created_at, Time.now
        expect(described_class.recent).to eq([article, newer_article])
      end
    end
  end
end
