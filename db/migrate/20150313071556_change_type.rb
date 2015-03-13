class ChangeType < ActiveRecord::Migration
  def change
    change_column(:broadcastings, :started_day, :string)
    change_column(:broadcastings, :ended_day, :string)
    change_column(:broadcastings, :started_time, :string)
  end
end
