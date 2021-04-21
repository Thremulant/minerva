require "test_helper"

class BookOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_orders_index_url
    assert_response :success
  end
end
