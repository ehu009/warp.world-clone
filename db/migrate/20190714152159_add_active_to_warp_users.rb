class AddActiveToWarpUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :warp_users, :active, :boolean, default: true
  end
end
