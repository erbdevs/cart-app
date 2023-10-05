module ApplicationHelper
  def current_cart
    session_cart = Cart.find_by_id(session[:cart_id])
    return session_cart if session_cart

    cart = Cart.create
    session[:cart_id] = cart.id

    cart
  end
end
