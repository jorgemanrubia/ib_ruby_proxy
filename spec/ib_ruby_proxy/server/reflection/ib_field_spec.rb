require 'spec_helper'
java_import 'com.ib.client.Contract'
java_import 'com.ib.client.ComboLeg'
require 'jruby/core_ext'

describe IbRubyProxy::Server::Reflection::IbField do
  subject(:ib_class) { IbRubyProxy::Server::Reflection::IbClass.new(Java::ComIbClient::Contract) }

  describe '#default_value' do
    it 'returns 0 for numeric values' do
      expect(field('strike').default_value).to eq(0)
    end

    it 'returns nil for string values' do
      expect(field('exchange').default_value).to be_nil
    end

    it 'returns false for boolean values' do
      expect(field('includeExpired').default_value).to eq(false)
    end
  end

  describe '#default_value_as_string' do
    it 'returns the string representation for numeric values' do
      expect(field('strike').default_value_as_string).to eq('0')
    end

    it 'returns the string nil for nil values' do
      expect(field('exchange').default_value_as_string).to eq('nil')
    end

    it 'returns the string representation for boolean values' do
      expect(field('includeExpired').default_value_as_string).to eq('false')
    end
  end

  describe '#name' do
    it 'returns the accessor name even when the property field uses a different case' do
      # the underlying field is m_lastTradedateOrContractMonth
      expect(field('lastTradeDateOrContractMonth').name).to eq('lastTradeDateOrContractMonth')
    end
  end

  def field(name)
    IbRubyProxy::Server::Reflection::IbField.new(find_field(name), ib_class)
  end

  def find_field(name)
    ib_class.java_property_fields.find { |field| field.name == name }.java_field
  end
end
