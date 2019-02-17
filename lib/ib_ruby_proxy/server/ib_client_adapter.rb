java_import 'com.ib.client.EClient'

module IbRubyProxy
  module Server
    class IbClientAdapter
      extend IbRubyProxy::Util::StringUtils

      attr_reader :ib_client, :ib_callbacks_adapter_wrapper

      def initialize(ib_client, ib_callbacks_adapter_wrapper)
        @ib_client = ib_client
        @ib_callbacks_adapter_wrapper = ib_callbacks_adapter_wrapper
      end

      def add_ib_callbacks_wrapper(client_ib_callbacks_wrapper)
        ib_callbacks_adapter_wrapper.add_observer(client_ib_callbacks_wrapper)
      end

      def self.define_ruby_method(java_method)
        ruby_method_name = to_underscore(java_method.name)

        class_eval  <<-RUBY
          def #{ruby_method_name}(*arguments)
            ib_arguments = arguments.collect(&:to_ib)
            @ib_client.#{java_method.name} *ib_arguments
          end
        RUBY
      end

      EClient.java_class.declared_instance_methods.each do |java_method|
        define_ruby_method(java_method)
      end
    end
  end
end

