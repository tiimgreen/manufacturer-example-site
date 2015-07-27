class AddOrderToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :order, :integer
  end
end
