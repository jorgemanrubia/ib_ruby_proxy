require 'spec_helper'
java_import 'com.ib.client.Contract'

describe IbRubyProxy::Server::Reflection::IbClass do
  subject(:ib_class) { described_class.new(Java::ComIbClient::Contract) }

  describe '#name' do
    it 'returns the simple class name' do
      expect(ib_class.name).to eq('Contract')
    end
  end

  describe '#full_name' do
    it 'returns the full qualified class name' do
      expect(ib_class.full_name).to eq('Java::ComIbClient::Contract')
    end
  end
end
