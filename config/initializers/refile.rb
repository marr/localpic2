require 'aws-sdk-v1'
require "refile/s3"

aws = {
  access_key_id: Rails.application.secrets.s3_access_key_id,
  secret_access_key: Rails.application.secrets.s3_secret,
  bucket: Rails.application.secrets.s3_bucket,
  region: Rails.application.secrets.s3_region
}

Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
