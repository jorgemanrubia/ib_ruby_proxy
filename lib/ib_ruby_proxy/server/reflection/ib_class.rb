module IbRubyProxy
  module Server
    module Reflection
      # An ib class
      class IbClass
        include IbRubyProxy::Util::StringUtils

        attr_reader :klass

        def initialize(klass)
          @klass = klass
        end

        # The class name without including namespaces
        #
        # @return [String]
        def name
          klass.name.split('::').last
        end

        # The full qualified class name including namespace
        #
        # @return [Object]
        def full_name
          klass.name
        end

        # List of ib fields that represent properties to interchange
        #
        # @return [Array<IbField>]
        def java_property_fields
          @java_property_fields ||= java_fields.collect { |field| IbField.new(field, self) }
        end

        # List of ruby properties names that correspond to {#java_property_fields}
        #
        # @return [Array<String>]
        def ruby_property_names
          @ruby_properties ||= java_property_fields.collect do |field|
            to_underscore(field.name)
          end
        end

        # Return an array of combinations of {#ruby_property_names} and #{java_property_fields}
        #
        # @return [Array<Array<String, IbField>>]
        def zipped_ruby_and_java_properties
          ruby_property_names.zip(java_property_fields)
        end

        private

        def java_fields
          @java_property_fields ||= klass.java_class.declared_fields.find_all do |field|
            field.name =~ IbField::IB_FIELD_PREFIX
          end
        end
      end
    end
  end
end
