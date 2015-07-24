class AddFetchedToTorrentFile < ActiveRecord::Migration
  def change
    add_column :torrent_files, :fetched, :boolean
  end
end
