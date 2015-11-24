require 'test_helper'

class Api::V1::PicturesControllerTest < ActionController::TestCase
  test "should post create" do
    @image = fixture_file_upload('files/panorama.jpg', 'image/jpeg')
    post :create, :picture => { :image => @image }
    assert_response :success
  end
end
