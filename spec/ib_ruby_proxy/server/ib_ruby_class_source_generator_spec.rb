require 'spec_helper'
java_import 'com.ib.client.Contract'
java_import 'com.ib.client.ComboLeg'
java_import 'com.ib.client.Types'

describe IbRubyProxy::Server::IbRubyClassSourceGenerator do
  describe '#ruby_class_source_for' do
    it 'generates a valid ruby object for a simple ib value object class' do
      evaluate_generated_source_for Contract, namespace: 'IbRubyProxy::Client::Ib::Test1'
      contract = IbRubyProxy::Client::Ib::Test1::Contract.new(last_trade_date_or_contract_month: '2018-2-4')
      expect(contract.last_trade_date_or_contract_month).to eq('2018-2-4')
    end
  end

  describe "Extended ib class" do
    before(:context) do
      evaluate_generated_source_for Contract, namespace: 'IbRubyProxy::Client::Ib::Test2'
    end


    describe '#to_ruby' do
      it 'should delete' do
        method = EClient.java_class.declared_instance_methods.first
        ap method.parameter_types
      end

      it 'should add a method to ruby that converts the ib object into a ruby object' do
        ib_contract = Java::ComIbClient::Contract.new
        ib_contract.symbol('ES')
        ib_contract.secType('FUT')
        ib_contract.currency('USD')
        ib_contract.exchange('GLOBEX')
        ib_contract.lastTradeDateOrContractMonth('201903')

        ruby_contract = ib_contract.to_ruby

        expect(ruby_contract).to be_instance_of(IbRubyProxy::Client::Ib::Test2::Contract)
        expect(ruby_contract.symbol).to eq('ES')
        expect(ruby_contract.sec_type).to eq(Types::SecType::FUT)
        expect(ruby_contract.currency).to eq('USD')
        expect(ruby_contract.exchange).to eq('GLOBEX')
        expect(ruby_contract.last_trade_date_or_contract_month).to eq('201903')
      end

      it 'should support converting arrays of objects' do
        ib_contract = Java::ComIbClient::Contract.new
        ib_combo_legs = 2.times.collect {|index| build_ib_combo_leg("Combo leg: #{index}")}
        ib_contract.comboLegs(ib_combo_legs)

        ruby_contract = ib_contract.to_ruby

        ruby_contract.combo_legs.each.with_index do |ruby_combo_leg, index|
          expect(ruby_combo_leg.exchange).to eq(ib_combo_legs[index].exchange)
        end
      end
    end
  end


  describe 'Generated ruby class' do
    before(:context) do
      evaluate_generated_source_for Contract, ComboLeg, namespace: 'IbRubyProxy::Client::Ib::Test3'
    end

    describe "#to_ib" do
      it 'creates an ib object with simple attributes copied' do
        ruby_contract = IbRubyProxy::Client::Ib::Test3::Contract.new symbol: 'ES',
                                                                     sec_type: 'FUT',
                                                                     currency: 'USD',
                                                                     exchange: 'GLOBEX',
                                                                     last_trade_date_or_contract_month: '201903'
        ib_contract = ruby_contract.to_ib

        expect(ib_contract).to be_an_instance_of(Java::ComIbClient::Contract)
        expect(ib_contract.symbol).to eq('ES')
        expect(ib_contract.secType).to eq(Types::SecType::FUT)
        expect(ib_contract.currency).to eq('USD')
        expect(ib_contract.exchange).to eq('GLOBEX')
        expect(ib_contract.lastTradeDateOrContractMonth).to eq('201903')
      end

      it 'should support converting arrays of objects' do
        ruby_contract = IbRubyProxy::Client::Ib::Test3::Contract.new
        ruby_combo_legs = 2.times.collect {|index| IbRubyProxy::Client::Ib::Test3::ComboLeg.new(exchange: "Combo leg: #{index}")}
        ruby_contract.combo_legs = ruby_combo_legs

        ib_contract = ruby_contract.to_ib

        ib_contract.comboLegs.each.with_index do |ib_combo_leg, index|
          expect(ib_combo_leg.exchange).to eq(ruby_combo_legs[index].exchange)
        end
      end
    end
  end

  def evaluate_generated_source_for(*ib_classes, namespace:)
    ib_classes.each do |ib_class|
      contract_generator = IbRubyProxy::Server::IbRubyClassSourceGenerator.new(ib_class, namespace: namespace)
      eval contract_generator.ruby_class_source
      eval contract_generator.ib_class_extension_source
    end
  end

  def build_ib_combo_leg(exchange)
    ib_combo_leg = Java::ComIbClient::ComboLeg.new
    ib_combo_leg.exchange(exchange)
    ib_combo_leg
  end
end
