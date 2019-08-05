require 'test_helper'

class Warp::LevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warp_level = warp_levels(:one)
  end

  test "should get index" do
    get warp_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_warp_level_url
    assert_response :success
  end

  test "should create warp_level" do
    assert_difference('Warp::Level.count') do
      post warp_levels_url, params: { warp_level: {  } }
    end

    assert_redirected_to warp_level_url(Warp::Level.last)
  end

  test "should show warp_level" do
    get warp_level_url(@warp_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_warp_level_url(@warp_level)
    assert_response :success
  end

  test "should update warp_level" do
    patch warp_level_url(@warp_level), params: { warp_level: {  } }
    assert_redirected_to warp_level_url(@warp_level)
  end

  test "should destroy warp_level" do
    assert_difference('Warp::Level.count', -1) do
      delete warp_level_url(@warp_level)
    end

    assert_redirected_to warp_levels_url
  end
end
