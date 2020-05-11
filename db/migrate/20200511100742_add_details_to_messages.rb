class AddDetailsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :receive_user_id, :integer
    add_column :messages, :receive_user_id_checked_message, :integer
  end
end
