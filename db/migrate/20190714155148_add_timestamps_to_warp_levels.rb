class AddTimestampsToWarpLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :warp_levels, :started_at, :datetime
    add_column :warp_levels, :completed_at, :datetime
  end
end
