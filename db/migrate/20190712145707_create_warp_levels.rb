class CreateWarpLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :warp_levels do |t|
      t.string :code
	    t.string :added_by
	    t.string :status
	    t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
