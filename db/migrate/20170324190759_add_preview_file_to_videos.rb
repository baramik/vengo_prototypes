class AddPreviewFileToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :preview_file, :string
  end
end
