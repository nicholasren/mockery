require "sinatra/base"
require "logger"

class MockingServer
  class App < Sinatra::Base
    use Rack::ShowExceptions
  end

  def run
    start
    yield if block_given?
  ensure
    shutdown
  end

  module Methods
    def mock_server(*args, &block)
      app = Class.new(Sinatra::Base)
      app.class_eval(&block)
      MockingServer.new(app, *args, &block)
    end
  end

protected

  def listening?(host, port)
    begin
      socket = TCPSocket.new(host, port)
      socket.close unless socket.nil?
      true
    rescue Errno::ECONNREFUSED,
      Errno::EBADF,           # Windows
      Errno::EADDRNOTAVAIL    # Windows
      false
    end
  end

  def wait_for_service(host, port, timeout = 5)
    start_time = Time.now

    until listening?(host, port)
      if timeout && (Time.now > (start_time + timeout))
        raise SocketError.new("Socket did not open within #{timeout} seconds")
      end
    end
    true
  end

  def initialize(app, port = 4000, &block)
    @app = app
    @port = port
  end

  def start
    @pid_server = fork do

      server_options = {
        :app => @app,
        :server => 'webrick',
        :environment => :none,
        :daemonize => false,
        :Port => @port
      }

      Rack::Server.start(server_options)
    end
    wait_for_service("0.0.0.0", @port)
    self
  end

  def shutdown
    Process.kill(:INT, @pid_server)
    Process.waitpid(@pid_server)
  end
end
