require 'test_helper'

class ShelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shel = shels(:one)
  end

  test "should get index" do
    get shels_url
    assert_response :success
  end

  test "should get new" do
    get new_shel_url
    assert_response :success
  end

  test "should create shel" do
    assert_difference('Shel.count') do
      post shels_url, params: { shel: { name: @shel.name, row: @shel.row } }
    end

    assert_redirected_to shel_url(Shel.last)
  end

  test "should show shel" do
    get shel_url(@shel)
    assert_response :success
  end

  test "should get edit" do
    get edit_shel_url(@shel)
    assert_response :success
  end

  test "should update shel" do
    patch shel_url(@shel), params: { shel: { name: @shel.name, row: @shel.row } }
    assert_redirected_to shel_url(@shel)
  end

  test "should destroy shel" do
    assert_difference('Shel.count', -1) do
      delete shel_url(@shel)
    end

    assert_redirected_to shels_url
  end
end
