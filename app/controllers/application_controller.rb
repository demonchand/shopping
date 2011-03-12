class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_and_load
    @cart = current_cart
  end
  
  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
