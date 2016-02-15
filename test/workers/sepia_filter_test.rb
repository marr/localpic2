require 'test_helper'
require "benchmark"
require 'sidekiq/testing'


class SepiaFilterTest < ActiveSupport::TestCase
  setup do
    image_path = "#{Rails.root}/test/fixtures/files/panorama.jpg"
    @picture = Picture.new
    File.open(image_path, 'rb') do |file|
      @picture.image = file
    end
    @picture.save
  end

  test 'sepia_filter_worker' do
    Sidekiq::Testing.inline! do
      #binding.pry # outputs full picture representation
      SepiaFilter.perform_async(@picture.image_id, @picture)
    end
    assert_not_equal @picture.updated_at, @picture.created_at
  end

  #test 'apply_filter_to_image' do
    #result = "#{Rails.root}/test/fixtures/files/result.jpg"
  #end

end

