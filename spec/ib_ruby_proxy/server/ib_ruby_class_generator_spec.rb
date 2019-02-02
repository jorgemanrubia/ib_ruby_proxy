require 'spec_helper'
java_import 'com.ib.client.Contract'

describe IbRubyProxy::Server::IbRubyClassGenerator do
  describe '#ruby_class_source_for' do
    it 'should generate a valid ruby object for a simple ib value object class' do
      generator = IbRubyProxy::Server::IbRubyClassGenerator.new(Contract, namespace: 'IbRubyProxy::Client::Ib::Test1')
      eval generator.ruby_class_source
      contract = IbRubyProxy::Client::Ib::Test1::Contract.new(last_tradedate_or_contract_month: '2018-2-4')
      expect(contract.last_tradedate_or_contract_month).to eq('2018-2-4')
    end
  end
end
