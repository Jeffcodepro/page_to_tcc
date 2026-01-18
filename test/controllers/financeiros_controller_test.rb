require "test_helper"

class FinanceirosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get financeiros_index_url
    assert_response :success
  end
end
