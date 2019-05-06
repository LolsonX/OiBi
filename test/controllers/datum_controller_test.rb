require 'test_helper'

class DatumControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get datum_index_url
    assert_response :success
  end

  test "should get new" do
    get datum_new_url
    assert_response :success
  end

  test "should get create" do
    get datum_create_url
    assert_response :success
  end

  test "should get destroy" do
    get datum_destroy_url
    assert_response :success
  end

end
