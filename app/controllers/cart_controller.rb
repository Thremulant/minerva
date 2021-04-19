class CartController < ApplicationController
  def create
    id = params[:id].to_i
    session[:cart] << id
    redirect_to request.referrer
  end

  def destroy
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to request.referrer
  end

  def index
    add_breadcrumb 'Cart', :cart_index_path
    @cart = session[:cart]
    @items = Book.find(@cart).uniq
  end
end
