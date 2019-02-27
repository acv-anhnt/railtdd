require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#index' do
    it 'gets a list of products' do
      products = create_list(:product, 10)
      get :index
      expect(assigns(:products).size).to eq products.size
    end
  end
end
