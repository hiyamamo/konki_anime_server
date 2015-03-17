class CreateTvStations < ActiveRecord::Migration
  def change
    create_table :tv_stations do |t|
      t.string :name
    end
  end
end
