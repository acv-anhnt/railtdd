class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  def new
  end
  def create
    @product = Product.create(product_params)
    redirect_to products_
  end
  def show
    @product = Product.find(params[:id])
  end
  def edit
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to product_path(@product)
  end
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
