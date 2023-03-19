FactoryBot.define do
  factory :article do
    sequence(:title, 'My article 1')
    sequence(:content, 'The content of article 1')
    sequence(:slug, 'article-1')
  end
end
