require 'test_helper'

class EncryptedFileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get encrypted_file_index_url
    assert_response :success
  end

  test "should get new" do
    get encrypted_file_new_url
    assert_response :success
  end

  test "should get create" do
    get encrypted_file_create_url
    assert_response :success
  end

  test "should get destroy" do
    get encrypted_file_destroy_url
    assert_response :success
  end

end
