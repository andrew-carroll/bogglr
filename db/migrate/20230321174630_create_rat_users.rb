class CreateRatUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :rat_users do |t|
      t.references :rat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
