# ---------------------------------------------
# File generated automatically by ib_ruby_proxy
# ---------------------------------------------

java_import "com.ib.client.ComboLeg"

class Java::ComIbClient::ComboLeg
  def to_ruby
    ruby_object = IbRubyProxy::Client::Ib::ComboLeg.new
    ruby_object.conid = conid()
    ruby_object.ratio = ratio()
    ruby_object.action = action()
    ruby_object.exchange = exchange()
    ruby_object.open_close = openClose()
    ruby_object.short_sale_slot = shortSaleSlot()
    ruby_object.designated_location = designatedLocation()
    ruby_object.exempt_code = exemptCode()

    ruby_object
  end
end
