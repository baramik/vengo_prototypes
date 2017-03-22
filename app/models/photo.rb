class Photo < ActiveRecord::Base
  mount_base64_uploader :file, PhotoUploader
end
