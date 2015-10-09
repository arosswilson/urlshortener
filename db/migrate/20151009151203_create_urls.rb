class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full_url, null: false
      t.string :short_code, null: false
      t.integer :access_count, null: false, default: 0

      t.timestamps
    end
  end
end