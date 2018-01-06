require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get likes" do
    get users_likes_url
    assert_response :success
  end

  test "should get login_form" do
    get users_login_form_url
    assert_response :success
  end

end
