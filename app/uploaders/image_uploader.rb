class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

# 이미지 썸네일 image.thumb.url 형태로 사용할 수 있음
  version :thumb do
    process resize_to_fill: [250 , 250]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
