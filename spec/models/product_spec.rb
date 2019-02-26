require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
  context 'association' do
    it { should belong_to(:category) }
  end
  context 'logic methods' do
    it 'Strips HTML from description' do
      category = Category.create!()
      product = Product.create!(title: 'Test HTML', price: 100, description: '<p>abc</p>', category: category)

      expect(product.description).to eq 'abc'
    end
    it 'Title lowercase after save' do
      category = Category.create!()
      product = Product.create!(title: 'TeST LOWER', price: 200, description: 'descriptionabc', category: category)
      expect(product.title).to eq 'test lower'
    end
    it 'Title is shorter than description' do
      category = Category.create!()
      product = Product.new(title: 'Longer than description', price: 200, description: 'shorter', category: category)
      product.validate
      expect(product.errors.messages).to include(title: ['can\'t longer than description'])
    end
  end
end
