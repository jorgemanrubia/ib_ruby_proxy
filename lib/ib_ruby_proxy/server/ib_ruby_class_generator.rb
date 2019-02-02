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
        #{generate_namespace_close}
        RUBY
      end

      private

      IB_FIELD_PREFIX = /^m_/

      def java_property_fields
        ib_class.java_class.declared_fields.find_all {|field| field.name =~ IB_FIELD_PREFIX
        }
      end

      def generate_namespace_open
        namespace_list.collect {|namespace| "module #{namespace}"}.join("\n")
      end

      def generate_namespace_close
        namespace_list.length.times.collect {"end"}.join("\n")
      end

      def generate_class_declaration
        struct_init_properties = ruby_property_attributes.collect{|property| ":#{property}"}.join(', ')
        struct_init_properties << ", keyword_init: true"
        "#{class_name} = Struct.new(#{struct_init_properties})"
      end

      def class_name
        ib_class.name.split('::').last
      end

      def ruby_property_attributes
        java_property_fields.collect do |field|
          field_name = field.name.gsub(IB_FIELD_PREFIX, '')
          to_underscore(field_name)
        end
      end
    end
  end
end
