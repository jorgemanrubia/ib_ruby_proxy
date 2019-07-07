require 'spec_helper'

describe '#req_historical_data', :impersonator do
  let(:client) { build_impersonated_client }
  let(:contract) { Test::Securities.emini }

  it 'returns the list of bars' do
    bars = []
    promise = Concurrent::Promises.resolvable_future.tap do |future|
      client.req_historical_data(18009, contract, '20190304 17:00:01', '1 M', '1 day',
                                 'TRADES', 1, 1, false, nil) do |callback, _request_id, bar|
        case callback
        when :historical_data
          bars << bar
        when :historical_data_end
          future.fulfill(bars)
        end
      end
    end

    bars = promise.value
    expect(bars.length).to be >= 10
    expect(bars.last).to be_a(IbRubyProxy::Client::Ib::Bar)
    expect(bars.last.open).to be >= 0
  end
end
