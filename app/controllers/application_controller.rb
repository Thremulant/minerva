class ApplicationController < ActionController::Base
  add_breadcrumb 'Home', :root_path
  before_action :initialize_session
  before_action :cart
  add_flash_types :info, :error, :warning, :success

  def initialize_session
    session[:cart] ||= []
  end

  def cart
    Book.find(session[:cart])
  end
end
