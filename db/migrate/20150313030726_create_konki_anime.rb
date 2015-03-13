class CreateKonkiAnime < ActiveRecord::Migration
  def change
    create_table :broadcastings do |t|
      t.string :title, :null => false
      t.date :started_day, :null => false
      t.date :ended_day, :null => false
      t.time :started_time, :null => false
      t.string :day_of_week, :null => false
      t.string :tv_station, :null => false
      t.timestamps
    end

  end
end
