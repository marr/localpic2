require 'test_helper'
require "benchmark"
require 'sidekiq/testing'


class ImageFilterTest < ActiveSupport::TestCase
  setup do
    image_path = "#{Rails.root}/test/fixtures/files/panorama.jpg"
    @picture = Picture.new
    File.open(image_path, 'rb') do |file|
      @picture.image = file
    end
    @picture.save
  end

  test 'image_filter_worker' do
    updated_at = @picture.updated_at
    Sidekiq::Testing.inline! do
      ImageFilter.perform_async(@picture.id)
    end
    assert_not_equal @picture.updated_at, updated_at
  end

  #test 'apply_filter_to_image' do
    #result = "#{Rails.root}/test/fixtures/files/result.jpg"
  #end

end
