class CreateWorlds < ActiveRecord::Migration
  def self.up
    drop_table :worlds
    create_table :worlds do |t|
      t.string :level_name
      t.boolean :hello_world
      t.boolean :spawn_monsters
      t.boolean :spawn_animals
      t.boolean :online_mode
      t.integer :max_players
      t.boolean :pvp
    end
  end

  def self.down
    drop_table :worlds
  end
end
