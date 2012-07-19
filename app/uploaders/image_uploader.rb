
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #def default_url
    #"https://image-posts.s3.amazonaws.com/uploads/challenge_evidence/image/4/trout_default.jpeg"
  #end

  version :thumb do
    process :resize_to_limit => [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
