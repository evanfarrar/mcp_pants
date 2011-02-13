class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.integer :world_id
      t.string :path
      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
