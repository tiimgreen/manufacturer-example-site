class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.integer :job_location_id
      t.string :apply_url

      t.timestamps null: false
    end
  end
end
