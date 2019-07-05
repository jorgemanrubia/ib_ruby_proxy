module IbRubyProxy
  module Server
    class IbRubyClassSourceGenerator
      include IbRubyProxy::Util::StringUtils

      attr_reader :ib_class, :namespace_list

      def initialize(ib_class, namespace: 'IbRubyProxy::Client::Ib')
        @ib_class = Reflection::IbClass.new(ib_class)
        @namespace_list = namespace.split('::')
      end

      def ruby_class_source
        <<-RUBY
        #{header}

        #{generate_ruby_class}
        RUBY
      end

      def ib_class_extension_source
        <<-RUBY
        #{header}

        #{generate_ib_class_extension}
        RUBY
      end

      private

      def header
        <<-RUBY
        # ---------------------------------------------
        # File generated automatically by ib_ruby_proxy
        # ---------------------------------------------
        RUBY
      end

      def generate_ib_class_extension
        <<-RUBY
        java_import "com.ib.client.#{ib_class.name}"

        class #{ib_class.full_name}
          #{generate_to_ruby_method}
        end
        RUBY
      end

      def generate_ruby_class
        <<-RUBY
        #{generate_namespace_open}

        #{generate_class_declaration}
          #{generate_constructor}
          #{generate_to_ib_method}
        end

        #{generate_namespace_close}
        RUBY
      end

      def generate_namespace_open
        namespace_list.collect { |namespace| "module #{namespace}" }.join("\n")
      end

      def generate_namespace_close
        namespace_list.length.times.collect { 'end' }.join("\n")
      end

      def generate_class_declaration
        struct_init_properties = ib_class.ruby_properties.collect { |property| ":#{property}" }
                                         .join(', ')
        struct_init_properties << ', keyword_init: true'

        <<-RUBY
          #{ib_class.name} = Struct.new(#{struct_init_properties}) do
        RUBY
      end

      def generate_constructor
        constructor_declarations = ib_class.zipped_ruby_and_java_properties
                                           .collect do |ruby_property, java_field|
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
        property_copy_sentences = ib_class.zipped_ruby_and_java_properties
                                          .collect do |ruby_property, java_field|
          <<-RUBY
          ib_object.#{java_field.name}(#{ruby_property}).to_java
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

      def generate_to_ruby_method
        property_copy_sentences = ib_class.zipped_ruby_and_java_properties
                                          .collect do |ruby_property, java_field|
          <<-RUBY
          ruby_object.#{ruby_property} = #{java_field.name}().to_ruby
          RUBY
        end

        <<-RUBY
        def to_ruby
          ruby_object = #{namespace_list.join('::')}::#{ib_class.name}.new
          #{property_copy_sentences.join('')}
          ruby_object
        end
        RUBY
      end
    end
  end
end
