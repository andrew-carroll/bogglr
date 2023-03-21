class CreateRats < ActiveRecord::Migration[7.0]
  def change
    create_table :rats do |t|
      t.string :name
      t.string :sex
      t.datetime :approx_birthday
      t.datetime :crossed_rainbow_bridge_at

      t.timestamps
    end
  end
end
