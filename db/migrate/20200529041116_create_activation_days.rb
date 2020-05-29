class CreateActivationDays < ActiveRecord::Migration[5.2]
  def change
    create_table :activation_days do |t|
      t.references :day_of_week, foreign_key: true
      t.references :team, foreign_key: true
      t.timestamps
    end
  end
end
