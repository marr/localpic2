class SepiaFilter < ServiceWorker
  sidekiq_options queue: :low
  sidekiq_options retry: 5

  sidekiq_retry_in { 3.minutes }
  sidekiq_retries_exhausted do |msg|
    logger.error "[worker][filter] Failed #{msg['class']} with #{msg['args']}:
                  #{msg['error_message']}"
  end

  def perform(id, pic)
    binding.pry # shows picture as just a string "=> #<Picture:0x007fccab0b7bb8"
    logger.info "[id=#{id}] FilterImages work started."
    #pic = Picture.find(id)
    file = pic.image.to_io #NoMethodError: undefined method `image' for "#<Picture:0x007f8bf765b6e0>":String
    file.close
    image = MiniMagick::Image.new(file.path)
    image.sepia_tone "80%"
    pic.image = file
    pic.save
  end
end
