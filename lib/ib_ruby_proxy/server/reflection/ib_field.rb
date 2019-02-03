module IbRubyProxy
  module Server
    module Reflection
      class IbField
        IB_FIELD_PREFIX = /^m_/

        attr_reader :java_field, :ib_class

        def initialize(java_field, ib_class)
          @java_field = java_field
          @ib_class = ib_class
        end

        def default_value
          case java_field.type
          when Java::int.java_class, Java::float.java_class, Java::double.java_class
            0
          when Java::boolean.java_class
            false
          else
            nil
          end
        end

        def default_value_as_string
          value = default_value
          if value.nil?
            'nil'
          else
            value.to_s
          end
        end

        def name
          @name ||= find_name
        end

        def list?
          java_field.type == Java::JavaUtil::List.java_class
        end

        def generic_type
          # Implementation based on `JavaField#to_generic_string` because `JavaField#value` is not defined, despite of giving
          # access to the underlying java field according to JRuby docs.
          #
          # `#to_generic_string` returns a string with this format:
          #   private java.util.List<com.ib.client.ComboLeg> com.ib.client.Contract.m_comboLegs
          full_class_name = java_field.to_generic_string[/<([^>]+)>/, 1]
          return nil unless full_class_name
          class_name = full_class_name.split('.').last
          Java::ComIbClient.const_get(class_name)
        end

        private

        def find_name
          field_name_without_prefix = java_field.name.gsub(IB_FIELD_PREFIX, '')
          method = ib_class.klass.java_class.declared_instance_methods.find {|method| method.name.downcase == field_name_without_prefix.downcase}
          raise "No method matching '#{field.name}'?" unless method
          method.name
        end
      end
    end
  end
end
