java_import 'com.ib.client.Contract'

module IbRubyProxy
  module Server
    module ConvertsRubyToIb
      def as_ib_contract(ruby_contract)
        generic_convert ruby_contract, Contract.new, :symbol, :secType, :currency, :exchange, :lastTradeDateOrContractMonth
      end

      def generic_convert(source_ruby_object, target_ib_object, *ib_properties)
        ib_properties.each do |ib_property|
          ruby_property = to_underscore(ib_property.to_s)
          ruby_property_value = source_ruby_object.send ruby_property
          target_ib_object.send ib_property, ruby_property_value
        end

        target_ib_object
      end

      private

      def to_underscore(camel_cased_string)
        camel_cased_string.gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
            gsub(/([a-z\d])([A-Z])/, '\1_\2').
            tr("-", "_").
            downcase
      end
    end
  end
end


