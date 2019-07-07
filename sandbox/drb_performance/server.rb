require 'drb'
require 'drb/observer'

class Server
  include DRb::DRbObservable
  attr_accessor :object

  def initialize
    @object = { id: 'from server side' }
  end

  def add(numnber1, number2)
    changed
    notify_observers(numnber1, number2, numnber1 + number2)
  end
end

server = Server.new

DRb.start_service('druby://localhost:1992', server)

begin
  DRb.thread.join
rescue StandardError
  Process.kill('TERM', Process.pid)
end
