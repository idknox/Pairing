CarrierWave.configure do |config|
  if Rails.env.test?
    config.fog_credentials = {
      :provider               => "AWS",
      :aws_access_key_id      => "aws_access_key_id",
      :aws_secret_access_key  => "aws_secret_access_key",
    }
  else
    config.fog_credentials = {
      :provider               => "AWS",
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    }
  end

  config.fog_directory  = "students-gschool-#{Rails.env}"
end
