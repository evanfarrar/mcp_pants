class CreateWarpPoints < ActiveRecord::Migration
  def self.up
    create_table :warp_points do |t|
      t.float :x
      t.float :y
      t.float :z
      t.string :name
      t.integer :player_id
      t.timestamps
    end
  end

  def self.down
    drop_table :warp_points
  end
end
