class CartController < ApplicationController
  helper_method :get_total
  add_flash_types :info, :error, :warning, :success
  def create
    id = params[:id].to_i
    session[:cart] << id
    # flash.now[:success] = 'A book was added to the cart'
    redirect_to request.referrer, success: 'A book was added to the cart'
  end

  def destroy
    id = params[:id].to_i

    session[:cart].delete(id)
    # session[:cart].reject{|k| k == id}
    redirect_to request.referrer
  end

  def patch
    id = params[:id].to_i
    session[:cart].delete_at(session[:cart].rindex(id) || session[:cart].length)
    redirect_to request.referrer
  end

  def index
    @cart = session[:cart]
    add_breadcrumb 'Cart', :cart_index_path
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @items = Book.find(@cart).uniq
    end
  end

  def get_total
    cart = session[:cart]
    prices = []

    cart.each do |id|
      quantity = cart.count(id)
      book = Book.find(id)
      prices << (book.price * quantity)
    end

    Rails.logger.debug(prices)
    prices.reduce(0, :+)
  end
end
