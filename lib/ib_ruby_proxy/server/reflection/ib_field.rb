module IbRubyProxy
  module Server
    module Reflection
      class IbField
        IB_FIELD_PREFIX = /^m_/

        attr_reader :java_field, :java_class

        def initialize(java_field, java_class)
          @java_field = java_field
          @java_class = java_class
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

        private

        def find_name
          field_name_without_prefix = java_field.name.gsub(IB_FIELD_PREFIX, '')
          method = java_class.java_class.declared_instance_methods.find {|method| method.name.downcase == field_name_without_prefix.downcase}
          raise "No method matching '#{field.name}'?" if !method
          method.name
        end
      end
    end
  end
end
