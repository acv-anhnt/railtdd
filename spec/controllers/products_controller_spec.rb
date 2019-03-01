require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:products) { create_list(:product, 10) }

  describe 'GET #index' do
    it 'gets a list of products' do
      get :index
      expect(assigns(:products).size).to eq products.size
      expect(response).to render_template :index
    end
    it 'route to index' do
      should route(:get, '/products').to(controller: :products, action: :index)
    end
  end

  describe 'GET #show' do
    let!(:product_individual) { create(:product) }
    it 'gets the product for detail' do
      get :show, params: { id: product_individual.id }
      expect(assigns(:product)).to eq product_individual
    end
    it 'get the show template' do
      get :show, params: { id: product_individual.id }
      expect(response).to render_template :show
    end
    it 'route to detail pages correctly' do
      should route(:get, '/products/1').to('products#show', id: 1)
    end
  end

  describe 'GET #new' do
    it 'get the new template' do
      get :new
      expect(response).to render_template :new
    end
    it 'route to new page correctly' do
      should route(:get, '/products/new').to('products#new')
    end
  end

  describe 'POST #create' do
    let!(:product) { build(:product) }
    let!(:invalid_product) { build(:product, title: 'this is', description: 'that')}
    context 'with valid attributes' do
      it 'save the new product in database' do
        expect{
          post :create,
          params: { product: product.attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirect to home page' do
        binding.pry
        expect(response).to redirect_to :index
      end
    end

    context 'with invalid attributes' do
      it 'does not save' do
        expect{
          post :create,
          params: { product: invalid_product.attributes }
        }.to_not change(Product, :count)
      end
    end
  end

  describe 'GET #edit' do
    let!(:product) { create(:product) }

    it 'get correct product for editing' do
      put :edit, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end

    it 'get the edit template' do
      get :edit, params: { id: product.id }
      expect(response).to render_template :edit
    end

    it 'route to edit page correctly' do
      should route(:get, '/products/1/edit').to('products#edit', id: 1)
    end
  end

  describe 'PUT #update' do
    let!(:product) { create(:product, title: 'test update') }

    it 'update successfully' do
      put :edit, params: { id: product.id, product: attributes_for(:product, title: 'updated')}
      product.reload

    end
    it 'route to update correctly' do
      should route(:patch, '/products/1').to('products#update', id: 1)
    end

    it 'redirect detail page' do
      put :edit, params: { id: product.id, product: attributes_for(:product, title: 'updated')}
      expect(response).to redirect_to action: :show, id: 1
    end
  end

  describe 'DELETE #destroy' do
    it 'route to destroy correctly' do
      should route(:delete, '/products/1').to('products#destroy', id: 1)
    end

    it 'destroy successfully the item' do
      expect{ delete :destroy, params: { id: 1 } }.to change(Product, :count).by(-1)
    end

    it 'redirect back to index after delete' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to products_path
    end
  end

end
