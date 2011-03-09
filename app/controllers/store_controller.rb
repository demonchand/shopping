class StoreController < ApplicationController
  def index
    @products = Product.all
    @cart = Cart.all
  end

end
