require 'spec_helper'

describe World do
  describe "time" do
    before do
      @world = World.new
    end

    describe "human time" do
      it "is 12:30 at 726500" do
        @world.stub(:system_epoch_time).and_return(726500)
        @world.human_time.should == "12:30"
      end
      it "is 12:01 at 726020" do
        @world.stub(:system_epoch_time).and_return(726020)
        @world.human_time.should == "12:01"
      end
      it "is 5:01 at 719020" do
        @world.stub(:system_epoch_time).and_return(719020)
        @world.human_time.should == "5:01"
      end
    end

    describe "sytem time" do
      it "is 6500 at 726500" do
        @world.stub(:system_epoch_time).and_return(726500)
        @world.system_time.should == 6500
      end
    end

  end
end
