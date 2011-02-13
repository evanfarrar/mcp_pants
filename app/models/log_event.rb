class LogEvent < ActiveRecord::Base
  after_create do
    if message =~ /.*\[INFO\] <([^>]*)> (.*)/
      player = Player.find_or_create_by_name($1)
      ChatMessage.create!(:message => $2, :player => player, :log_event => self)
    end
    if message =~ /.*\[INFO\] <([^>]*)> !t (.*)/
      from = Player.find_or_create_by_name($1)
      to = Player.find(:first, :conditions => "name like '#{$2}%'")
      tele = Teleport.new(:from => from, :to => to)
      tele.perform
    end
    if message =~ /.*\[INFO\] <([^>]*)> !motd$/
      sayer = Player.find_or_create_by_name($1)
      motd = Motd.last
      ServerWrapper.run_remote("tell #{$1} #{motd.body}") if motd
    end
    if message =~ /.*\[INFO\] <([^>]*)> !motd (.+)$/
      motd = Motd.create!(:body => $2)
    end
    if message =~ /.*\[INFO\] ([^ ]*).*logged in with entity id/
      motd = Motd.last
      ServerWrapper.run_remote("tell #{$1} #{motd.body}") if motd
    end
  end
end
