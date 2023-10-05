module ApplicationHelper
  def current_cart
    session_cart = Cart.find_by_id(session[:cart])
    return session_cart if session_cart

    Cart.new
  end
end
