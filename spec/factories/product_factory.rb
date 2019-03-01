FactoryBot.define do

  factory :product do
    title { 'Test product' }
    description { 'product for testing' }
    price { 300 }
    category { create(:category) }
  end
end
