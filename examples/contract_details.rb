require 'drb'
require 'ib_ruby_proxy'
require_relative './securities'

client = IbRubyProxy::Client::Client.from_drb

promise = client.req_contract_details(18009, Securities.emini).then do |contract_details_list|
  ap contract_details_list
end

promise.value # block until promise resolved



