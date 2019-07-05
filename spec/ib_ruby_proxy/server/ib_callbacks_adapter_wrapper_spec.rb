require 'spec_helper'

describe IbRubyProxy::Server::IbCallbacksAdapterWrapper do
  subject(:adapter) { described_class.new }

  it 'emits a notification containing the ruby name of the method to invoke and the arguments'\
      'including transformed ruby objects from ib' do
    observer = double('wrapper observer', update: nil)
    adapter.add_observer(observer)
    expect(observer).to receive(:update).with('historical_data', 4001, expected_ruby_bar)
    adapter.historicalData(4001, ib_bar)
  end

  def ib_bar
    Java::ComIbClient::Bar.new '12345', 1, 2, 3, 4, 5, 6, 7
  end

  def expected_ruby_bar
    IbRubyProxy::Client::Ib::Bar.new time: '12345', open: 1.0, high: 2.0, low: 3.0, close: 4.0,
                                     volume: 5, count: 6, wap: 7.0
  end
end
