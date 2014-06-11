Rails.application.config.to_prepare do
  S3_CONFIG = YAML.load_file("config/s3.yml")[Rails.env]
end