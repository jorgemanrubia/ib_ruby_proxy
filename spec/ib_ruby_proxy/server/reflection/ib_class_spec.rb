require 'spec_helper'
java_import 'com.ib.client.Contract'

describe IbRubyProxy::Server::Reflection::IbClass do
  subject(:ib_class){IbRubyProxy::Server::Reflection::IbClass.new(Java::ComIbClient::Contract)}

  describe '#name' do
    it 'returns the simple class name' do
      expect(ib_class.name).to eq('Contract')
    end
  end
end
