require 'drb'
require 'ib_ruby_proxy'
require_relative './securities'

client = IbRubyProxy::Client::Client.from_drb

promise = client.req_contract_details(18009, Securities.emini).then do |contract_details_list|
  contract_details_list.each do |request_id, contract_details|
    ap contract_details
  end
end

promise.rescue { |error| puts "Error receiving contract details: #{error}" }

promise.value

DRb.stop_service

