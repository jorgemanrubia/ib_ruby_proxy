module IbRubyProxy
  module Server
    module Reflection
      # An {IbClass} field
      class IbField
        IB_FIELD_PREFIX = /^m_/.freeze

        attr_reader :java_field, :ib_class

        def initialize(java_field, ib_class)
          @java_field = java_field
          @ib_class = ib_class
        end

        # Default value for the field
        #
        # @return [Object]
        def default_value
          case java_field.type
          when Java::int.java_class, Java::float.java_class, Java::double.java_class
            0
          when Java::boolean.java_class
            false
          end
        end

        # {#default_value Default value} as a string
        #
        # @return [String]
        def default_value_as_string
          value = default_value
          if value.nil?
            'nil'
          else
            value.to_s
          end
        end

        # Return the name of the accessor method used to access the field
        #
        # @return [String]
        def name
          @name ||= find_name
        end

        private

        def find_name
          field_name_without_prefix = java_field.name.gsub(IB_FIELD_PREFIX, '')
          matched_method = ib_class.klass.java_class.declared_instance_methods.find do |method|
            method.name.downcase == field_name_without_prefix.downcase
          end
          raise "No method matching '#{field.name}'?" unless matched_method

          matched_method.name
        end
      end
    end
  end
end
