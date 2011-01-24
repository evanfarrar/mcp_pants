require 'thread'
require 'open3'
class ServerWrapper
  class << self
    def start
      @@single = ServerWrapper.new
    end

    def run(command)
      @@single.run(command)
    end

    def stop
      @@single.stop
    end
  end

  cattr_accessor :single
  
  def initialize
    puts `pwd`
    server = "cd tmp/server && java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui"
    #stdin, stdout, stderr, wait_thr = Open3.popen3(server)
    @pid, @server_in, @server_out, @server_err = Open4::popen4(server)

    parent_pid = Process.pid
    out_reader = Process.fork
    err_reader = Process.fork unless out_reader.nil?
    own_pid = Process.pid

    while(out_reader.nil? || err_reader.nil?) # if child
      # child 1, stdout of server
      if out_reader.nil?
          @server_out.each_line do |line|
            puts line
            LogEvent.create!(:message => line)
          end
        sleep 0.1
      end

      # child 2, stderr of server
      if !out_reader.nil? and err_reader.nil?
        @server_err.each_line do |line|
          line.strip!
          puts line
          LogEvent.create!(:message => line)
        end
        sleep 0.1
      end
    end
  end

  def run(command)
    @server_in.puts command
  end
  
  def stop
    `kill #{@pid}`
  end
end
