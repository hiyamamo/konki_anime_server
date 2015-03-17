class AddUrl < ActiveRecord::Migration
  def change
    add_column :broadcastings, :url, :string
  end
end
