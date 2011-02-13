require 'spec_helper'

describe Map do
  describe "after create" do
    it "makes a map file" do
      levelname = "mapworld-#{UUID.create_random}"
      world = World.create(:level_name => levelname)    
      map = Map.new(:world => world)
      map.should_receive(:write_map_file)

      map.save!

      map.path.should == "/images/maps/#{map.id}.png"
    end
  end
end
