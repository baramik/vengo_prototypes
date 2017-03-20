class Video < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :file, VideoUploader
  
  def default_name
    # self.name ||= File.basename(file.name.to_s, '.*').titleize if file
  end
end
