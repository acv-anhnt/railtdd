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
    let!(:product) { create(:product, description: '<p>abcccccccccccccccc</p>', title: 'TEST LOWER' ) }
    let!(:build_product) { build(:product, description: 'abc')}

    it 'Strips HTML from description' do
      expect(product.description).to eq 'abcccccccccccccccc'
    end
    it 'Title lowercase after save' do
      expect(product.title).to eq 'test lower'
    end
    it 'Title is shorter than description' do
      build_product.validate
      expect(build_product.errors.messages).to include(title: ['can\'t longer than description'])
    end
  end
end
