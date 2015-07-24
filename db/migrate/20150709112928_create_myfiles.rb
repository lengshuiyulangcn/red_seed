class CreateMyfiles < ActiveRecord::Migration
  def change
    create_table :myfiles do |t|
      t.string :file_name
      t.string :file_path
      t.string :file_md5

      t.timestamps null: false
    end
  end
end
