require 'spec_helper'

describe '#req_historical_ticks', :impersonator do
  let(:client) { build_impersonated_client }
  let(:contract) { Test::Securities.emini }

  it 'returns the list of ticks' do
    promise = Concurrent::Promises.resolvable_future.tap do |future|
      client.req_historical_ticks(18001, contract, nil, '20190304 17:00:01', 10,
                                  'MIDPOINT', 1, false, nil) do |_callback, _request_id, ticks, _done|
        future.fulfill(ticks)
      end
    end
    ticks = promise.value
    expect(ticks.length).to be >= 10
    expect(ticks.last).to be_a(IbRubyProxy::Client::Ib::HistoricalTick)
    expect(ticks.last.price).to be >= 0
  end
end
