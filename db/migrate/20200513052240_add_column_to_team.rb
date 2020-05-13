class AddColumnToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :address, :string
    add_column :teams, :latitude, :float
    add_column :teams, :longitude, :float
  end
end
