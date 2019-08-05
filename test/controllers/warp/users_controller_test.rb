require 'test_helper'

class Warp::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warp_user = warp_users(:one)
  end

  test "should get index" do
    get warp_users_url
    assert_response :success
  end

  test "should get new" do
    get new_warp_user_url
    assert_response :success
  end

  test "should create warp_user" do
    assert_difference('Warp::User.count') do
      post warp_users_url, params: { warp_user: {  } }
    end

    assert_redirected_to warp_user_url(Warp::User.last)
  end

  test "should show warp_user" do
    get warp_user_url(@warp_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_warp_user_url(@warp_user)
    assert_response :success
  end

  test "should update warp_user" do
    patch warp_user_url(@warp_user), params: { warp_user: {  } }
    assert_redirected_to warp_user_url(@warp_user)
  end

  test "should destroy warp_user" do
    assert_difference('Warp::User.count', -1) do
      delete warp_user_url(@warp_user)
    end

    assert_redirected_to warp_users_url
  end
end
