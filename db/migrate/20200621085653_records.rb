class Records < ActiveRecord::Migration[5.1]
  def change
    drop_table :memberships
    drop_table :messages
    drop_table :talks
    drop_table :messages
    drop_table :rooms
    drop_table :entries
  end
end
