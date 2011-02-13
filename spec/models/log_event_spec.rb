require 'spec_helper'

describe LogEvent do
  before do
    ChatMessage.destroy_all
    ChatMessage.last.should be_nil
  end
  describe "create" do
    it "creates a chat message" do
      LogEvent.create!(:message => "2011-01-23 06:25:16 [WARNING] Can't keep up! Did the system time change, or is the server overloaded?")
      ChatMessage.last.should be_nil
      log = LogEvent.create!(:message => "2011-01-23 06:54:58 [INFO] <evanfarrar> yo")
      last_message = ChatMessage.last

      last_message.should_not be_nil
        
      last_message.player.name.should == "evanfarrar"
      last_message.message.should == "yo"
      last_message.log_event.should == log
    end

    it "creates a teleport on !t" do
      evan = Player.create!(:name => "evanfarrar")
      levi = Player.create!(:name => "levi5mpls")
      ServerWrapper.should_receive(:run_remote).with("tp evanfarrar levi5mpls")
      LogEvent.create!(:message => "2011-01-23 06:25:16 [INFO] <evanfarrar> !t levi")
    end

    it "sets the motd on !motd with a body" do
      LogEvent.create!(:message => "2011-01-23 06:25:16 [INFO] <evanfarrar> !motd Welcome!")
      Motd.last.body.should == "Welcome!"
    end

    it "whispers the motd back on !motd without a body" do
      Motd.create(:body => "Welcome!")
      ServerWrapper.should_receive(:run_remote).with("tell evanfarrar Welcome!")
      LogEvent.create!(:message => "2011-01-23 06:25:16 [INFO] <evanfarrar> !motd")
    end

    it "sends players motd on login" do
      Motd.create(:body => "Welcome!")
      ServerWrapper.should_receive(:run_remote).with("tell evanfarrar Welcome!")
      LogEvent.create!(:message => "2011-02-12 22:13:00 [INFO] evanfarrar [/127.0.0.1:51464] logged in with entity id 5171")
    end
  end
end
