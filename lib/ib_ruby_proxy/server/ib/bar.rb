# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.Bar"

class Java::ComIbClient::Bar
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::Bar.new
    ruby_object.time = time().to_ruby
    ruby_object.open = open().to_ruby
    ruby_object.high = high().to_ruby
    ruby_object.low = low().to_ruby
    ruby_object.close = close().to_ruby
    ruby_object.volume = volume().to_ruby
    ruby_object.count = count().to_ruby
    ruby_object.wap = wap().to_ruby

    ruby_object
  end
end
