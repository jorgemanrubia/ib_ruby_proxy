require 'drb'
require 'benchmark'

# This is a dummy performance test to have an idea of drb throughput. I got it's possible to process 10000 notifications
# per second with MRI ruby 2.5, which should be enough for real time tick data.
class ResultCallback
  include DRbUndumped

  attr_reader :total

  def initialize
    @total = 0
  end

  def update(number1, number2, result)
    @total += result
  end
end

@server = DRbObject.new(nil, "druby://localhost:1992")
DRb.start_service

result_callback = ResultCallback.new
@server.add_observer(result_callback)

LOOP_COUNT = 10000

drb_benchmark = Benchmark.measure do
  LOOP_COUNT.times do |i|
    @server.add(i, i+1)
  end

end

total = 0
ruby_benchmark = Benchmark.measure do
  LOOP_COUNT.times do |i|
    total += (i + (i+1))
  end
end

puts "With drb: #{result_callback.total}"
puts drb_benchmark

puts "With plain ruby: #{total}"
puts ruby_benchmark
