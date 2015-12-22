require 'rubygems'

class ServiceWorker
  include Sidekiq::Worker

  class RequestError < StandardError; end
  class BadRequestError < RequestError; end
  class UnknownRequestError < RequestError; end

  protected

    # download images to process from S3
    def download(path)
    end

    # upload processed images to S3
    def upload(file, content_type, relative_path)
    end

  private

    def setup_options_as_instance_variables(options)
      options.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
end
