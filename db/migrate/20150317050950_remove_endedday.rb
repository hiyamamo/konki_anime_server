class RemoveEndedday < ActiveRecord::Migration
  def change
    remove_column :broadcastings, :ended_day
  end
end
