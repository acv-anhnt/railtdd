class AddReferenceInProductsToCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, index: true
  end
end
