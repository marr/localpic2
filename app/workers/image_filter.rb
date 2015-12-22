class ImageFilter < ServiceWorker
  sidekiq_options queue: :low

  sidekiq_options retry: 5
  sidekiq_retry_in { 3.minutes }

  sidekiq_retries_exhausted do |msg|
    logger.error "[worker][filter] Failed #{msg['class']} with #{msg['args']}:
                  #{msg['error_message']}"
  end

  def perform(id)
    logger.info "[id=#{id}] FilterImages work started."
    pic = Picture.find(id)
    file = pic.image.to_io
    image = MiniMagick::Image.new(file.path)
    image.sepia_tone "80%"
    pic.image = file
    pic.save
  end
end
