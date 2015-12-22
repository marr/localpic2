require 'test_helper'
require "benchmark"
require 'sidekiq/testing/inline'

class ImageFilterTest < ActiveSupport::TestCase
  setup do
    @image = "#{Rails.root}/test/fixtures/files/panorama.jpg"
    ImageFilter.jobs.clear
  end

  test 'image_filter_worker' do
    ImageFilter.perform_async(id: 1, image: @image)
    assert_equal 1, ImageFilter.jobs.size
    ImageFilter.clear
  end

  test 'apply_filter_to_image' do
    result = "#{Rails.root}/test/fixtures/files/result.jpg"
  end

end
