class AddStatusToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :status, :string, default: "converted"
  end
end
