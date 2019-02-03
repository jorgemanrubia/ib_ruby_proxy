module IbRubyProxy
  module Server
    class IbRubyClassGenerator
      include IbRubyProxy::Util::StringUtils

      attr_reader :ib_class, :namespace_list, :ib_class

      def initialize(ib_class, namespace: 'IbRubyProxy::Client::Ib')
        @ib_class = Reflection::IbClass.new(ib_class)
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


      def generate_namespace_open
        namespace_list.collect {|namespace| "module #{namespace}"}.join("\n")
      end

      def generate_namespace_close
        namespace_list.length.times.collect {"end"}.join("\n")
      end

      def generate_class_declaration
        struct_init_properties = ib_class.ruby_properties.collect {|property| ":#{property}"}.join(', ')
        struct_init_properties << ", keyword_init: true"

        <<-RUBY
          #{ib_class.name} = Struct.new(#{struct_init_properties}) do
        RUBY
      end

      def generate_constructor
        constructor_declarations = ib_class.zipped_ruby_and_java_properties.collect do |ruby_property, java_field|
          "#{ruby_property}: #{java_field.default_value_as_string}"
        end

        assignment_statements = ib_class.ruby_properties.collect do |ruby_property|
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

      def generate_to_ib_method
        property_copy_sentences = ib_class.zipped_ruby_and_java_properties.collect do |ruby_property, java_field|
#          puts "#{java_field.type}-#{java_field.to_generic_string}"

          <<-RUBY
          ib_object.#{java_field.name}(#{ruby_property})
          RUBY
        end

        <<-RUBY
        def to_ib
          ib_object = #{ib_class.klass.name}.new
          #{property_copy_sentences.join('')}
          ib_object             
        end
        RUBY
      end
    end
  end
end
