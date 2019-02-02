module IbRubyProxy
  module Server
    class IbRubyClassGenerator
      include IbRubyProxy::Util::StringUtils

      attr_reader :ib_class, :namespace_list

      def initialize(ib_class, namespace: 'IbRubyProxy::Client::Ib')
        @ib_class = ib_class
        @namespace_list = namespace.split('::')
      end

      def ruby_class_source
        <<-RUBY
        #{generate_namespace_open}
        #{generate_class_declaration}
          #{generate_constructor}
          #{generate_to_ib_method}
        end
        #{generate_namespace_close}
        RUBY
      end

      private

      IB_FIELD_PREFIX = /^m_/

      def java_property_fields
        @java_property_fields ||= ib_class.java_class.declared_fields.find_all {|field| field.name =~ IB_FIELD_PREFIX}
      end

      def generate_namespace_open
        namespace_list.collect {|namespace| "module #{namespace}"}.join("\n")
      end

      def generate_namespace_close
        namespace_list.length.times.collect {"end"}.join("\n")
      end

      def generate_class_declaration
        struct_init_properties = ruby_properties.collect {|property| ":#{property}"}.join(', ')
        struct_init_properties << ", keyword_init: true"

        <<-RUBY
          #{class_name} = Struct.new(#{struct_init_properties}) do
        RUBY
      end

      def generate_constructor
        constructor_declarations = ruby_properties.zip(java_property_fields).collect do |ruby_property, java_field|
          "#{ruby_property}: #{default_value_for_java_field(java_field)}"
        end

        assignment_statements = ruby_properties.collect do |ruby_property|
          <<-RUBY
            self.#{ruby_property} = #{ruby_property}
          RUBY
        end

        <<-RUBY
            def initialize(#{constructor_declarations.join(', ')})
              #{assignment_statements.join('')}        
            end
        RUBY
      end

      def default_value_for_java_field(java_field)
        case java_field.type
        when Java::int.java_class, Java::float.java_class, Java::double.java_class
          '0'
        when Java::boolean.java_class
          'false'
        else
          'nil'
        end
      end

      def class_name
        ib_class.name.split('::').last
      end

      def ruby_properties
        @ruby_properties ||= java_property_fields.collect do |field|
          field_name = field_name(field)
          to_underscore(field_name)
        end
      end

      # Sometimes the case of the private method and the accessor does not match
      def field_name(field)
        field_name_without_prefix = field.name.gsub(IB_FIELD_PREFIX, '')
        method = ib_class.java_class.declared_instance_methods.find {|method| method.name.downcase == field_name_without_prefix.downcase}
        raise "No method matching '#{field.name}'?" if !method
        method.name
      end

      def generate_to_ib_method
        property_copy_sentences = ruby_properties.collect do |ruby_property|
          java_setter = to_camel_case(ruby_property)
          <<-RUBY
            ib_object.#{java_setter}(#{ruby_property})
          RUBY
        end

        <<-RUBY
          def to_ib
            ib_object = #{ib_class.name}.new
            #{property_copy_sentences.join('')}
            ib_object             
          end
        RUBY
      end
    end
  end
end
