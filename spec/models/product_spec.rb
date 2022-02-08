require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a product with all valid fields' do
      @category = Category.create(name: 'Toys')
      @product = Product.create(name: 'Nerf Blaster', price: 100000, quantity: 35, category_id: @category.id)
      
      expect(@product.errors.full_messages).to be_empty
    end

    it 'cannot save because the name is blank' do
      @category = Category.create(name: 'Toys')
      @product = Product.create(name: nil, price: 100000, quantity: nil, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'cannot save because the price is blank' do
      @category = Category.create(name: 'Toys')
      @product = Product.create(name: 'Nerf Blaster', price: nil, quantity: 35, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'cannot save because the quantity is blank' do
      @category = Category.create(name: 'Toys')
      @product = Product.create(name: 'Nerf Blaster', price: 100000, quantity: nil, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'cannot save because the category is blank' do
      @product = Product.create(name: 'Nerf Blaster', price: 100000, quantity: nil, category_id: nil)

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
