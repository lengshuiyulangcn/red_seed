class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :seed_hash
      t.string :path
      t.string :base_name

      t.timestamps null: false
    end
  end
end
