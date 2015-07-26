class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_email, default: ''
      t.string :job_title
      t.string :short_info

      t.timestamps null: false
    end
  end
end
