class CreateTorrentFiles < ActiveRecord::Migration
  def change
    create_table :torrent_files do |t|
      t.string :torrent_hash
      t.string :file_path

      t.timestamps null: false
    end
  end
end
