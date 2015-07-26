class CreateJobLocations < ActiveRecord::Migration
  def change
    create_table :job_locations do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
