class CreateRatPhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :rat_photos do |t|
      t.belongs_to :rat, null: false, foreign_key: true
      t.belongs_to :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
