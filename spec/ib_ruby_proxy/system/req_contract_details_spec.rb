require 'spec_helper'

describe '#req_contract_details', :impersonator do
  let(:client) { build_impersonated_client }
  let(:contract) { Test::Securities.emini }

  it 'returns the contract details' do
    promise = Concurrent::Promises.resolvable_future.tap do |future|
      client.req_contract_details(18009, contract) do |callback, _request_id, contract_details|
        future.fulfill(contract_details) if callback == :contract_details
      end
    end
    contract = promise.value
    expect(contract.long_name).to eq('E-mini S&P 500')
    expect(contract).to be_a(IbRubyProxy::Client::Ib::ContractDetails)
  end
end
