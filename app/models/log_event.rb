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
  end
end
