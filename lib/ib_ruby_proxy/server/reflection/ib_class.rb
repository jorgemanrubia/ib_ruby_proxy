module IbRubyProxy
  module Server
    module Reflection
      class IbClass
        include IbRubyProxy::Util::StringUtils

        attr_reader :klass

        def initialize(klass)
          @klass = klass
        end

        def name
          klass.name.split('::').last
        end

        def full_name
          klass.name
        end

        def java_property_fields
          @java_property_fields ||= java_fields.collect{|field| IbField.new(field, self)}
        end

        def ruby_properties
          @ruby_properties ||= java_property_fields.collect do |field|
            to_underscore(field.name)
          end
        end

        def zipped_ruby_and_java_properties
          ruby_properties.zip(java_property_fields)
        end

        private

        def java_fields
          @java_property_fields ||= klass.java_class.declared_fields.find_all {|field| field.name =~ IbField::IB_FIELD_PREFIX}
        end
      end
    end
  end
end
