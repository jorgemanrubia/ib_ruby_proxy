# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.DeltaNeutralContract"

class Java::ComIbClient::DeltaNeutralContract
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::DeltaNeutralContract.new
    ruby_object.conid = conid().to_ruby
    ruby_object.delta = delta().to_ruby
    ruby_object.price = price().to_ruby

    ruby_object
  end
end
