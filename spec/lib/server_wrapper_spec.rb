require 'spec_helper'

describe ServerWrapper do
  after do
    ServerWrapper.stop
  end

  describe "#start" do
    it "starts a process" do
      start_command = /java -Xmx1024M -Xms1024M -jar .*minecraft_server/
      (`ps wwaux`).grep(start_command).should be_empty
      ServerWrapper.start
      sleep 3
      (`ps wwaux`).grep(start_command).should_not be_empty
    end
  end

end
