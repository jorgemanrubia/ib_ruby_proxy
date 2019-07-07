require 'spec_helper'

describe '#req_contract_details', :impersonator do
  let(:client) do
    impersonated_client = Impersonator.impersonate(:req_contract_details) do
      IbRubyProxy::Client::Client.from_drb
    end
    impersonated_client.configure_method_matching_for(:req_contract_details) do |config|
      config.ignore_arguments_at 0
    end
    impersonated_client
  end
  let(:contract) do
    IbRubyProxy::Client::Ib::Contract.new symbol: 'ES',
                                          sec_type: 'FUT',
                                          currency: 'USD',
                                          exchange: 'GLOBEX',
                                          last_trade_date_or_contract_month: '201909'
  end

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
