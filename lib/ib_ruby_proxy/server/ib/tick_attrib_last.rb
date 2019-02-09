# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.TickAttribLast"

class Java::ComIbClient::TickAttribLast
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::TickAttribLast.new
    ruby_object.past_limit = pastLimit().to_ruby
    ruby_object.unreported = unreported().to_ruby

    ruby_object
  end
end
