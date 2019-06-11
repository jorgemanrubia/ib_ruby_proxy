require_relative './common'

client = IbRubyProxy::Client::Client.from_drb

client.req_contract_details(18009, Securities.emini) do |_callback, _request_id, contract_details|
  ap contract_details
end

sleep


