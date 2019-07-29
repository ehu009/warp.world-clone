class CreateWarpUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :warp_users do |t|
      t.string :api_key
	  t.string :channel_name
      t.timestamps
    end
  end
end
