require 'test_helper'

class Api::V1::PicturesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should post create" do

    @image = fixture_file_upload('files/panorama.jpg', 'image/jpeg')
    post :create, :picture => { :image => @image }
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
