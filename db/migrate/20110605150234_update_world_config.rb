class UpdateWorldConfig < ActiveRecord::Migration
  def self.up
    change_table :worlds do |t|
      t.boolean :hellworld
      t.boolean :allow_nether
      t.string :view_distance
      t.string :server_ip
      t.string :server_port
      t.boolean :allow_flight
      t.boolean :white_list
      t.string :level_seed
    end
  end

  def self.down
    remove_column :worlds, :hellworld
    remove_column :worlds, :allow_nether
    remove_column :worlds, :view_distance
    remove_column :worlds, :server_ip
    remove_column :worlds, :server_port
    remove_column :worlds, :allow_flight
    remove_column :worlds, :white_list
    remove_column :worlds, :level_seed
  end
end
