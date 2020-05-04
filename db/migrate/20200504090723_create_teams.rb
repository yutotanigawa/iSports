class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :genre_id, null: false
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :team_image_id
      t.integer :prefecture, null: false
      t.integer :day_of_week, null: false
      t.integer :frequency, null: false
      t.text :introduction, null: false
      t.integer :publication_status, null: false, default: 0

      t.timestamps
    end
  end
end
