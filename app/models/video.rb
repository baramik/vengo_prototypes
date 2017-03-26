class Video < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :file, VideoUploader
  mount_uploader :preview_file, VideoUploader
  
  def default_name
    # self.name ||= File.basename(file.name.to_s, '.*').titleize if file
  end
  
  def save_preview(key_output)
    self[:preview_file] = key_output.sub "#{self.file.store_dir}/", ""
    self.save
    self.preview_file_url
  end
  
  def save_preview_to_file
    self[:file] = self[:preview_file]
    self.save
  end
end
