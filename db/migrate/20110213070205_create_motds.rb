class CreateMotds < ActiveRecord::Migration
  def self.up
    create_table :motds do |t|
      t.string :body
      t.string :creator
      t.timestamps
    end
  end

  def self.down
    drop_table :motds
  end
end
