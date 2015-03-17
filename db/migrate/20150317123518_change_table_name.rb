class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table:broadcastings, :programs
  end
end
