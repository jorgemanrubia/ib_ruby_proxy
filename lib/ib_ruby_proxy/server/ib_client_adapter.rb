java_import 'com.ib.client.EClient'

module IbRubyProxy
  module Server
    # This is the Ruby representation of the IB Java +EClient+ class. It adapts ruby invocations
    # and arguments to invoke the corresponding Java API methods.
    #
    # It is the object DRb clients get when connecting to the {IbProxyService proxy service}.
    #
    # Mimicking how the Java API works, it collaborates with an {IbWrapperAdapter} that
    # corresponds with an +EWrapper+ in the Java world. It works by observing callbacks
    # in this wrapper.
    #
    # The usage of observers as a communication mechanism is because it is supported
    # by DRb and, being DRb a standard implemented in JRuby, enables communicating Ruby and JRuby.
    # If supporting other rubies was not required this level of indirection would be unnecessary.
    class IbClientAdapter
      extend IbRubyProxy::Util::StringUtils

      attr_reader :ib_client, :ib_wrapper_adapter

      # @param [com.ib.client.EClientSocket] ib_client IB +EClientSocket+ object
      # @param [IbWrapperAdapter] ib_wrapper_adapter
      def initialize(ib_client, ib_wrapper_adapter)
        @ib_client = ib_client
        @ib_wrapper_adapter = ib_wrapper_adapter
      end

      def ib_client_connected?
        @ib_client.isConnected
      end

      # @param [IbRubyProxy::Client::IbCallbacksObserver] ib_callbacks_observer
      def add_ib_callbacks_observer(ib_callbacks_observer)
        ib_wrapper_adapter.add_observer(ib_callbacks_observer)
      end

      # @private
      def self.define_ruby_method_for(java_method)
        ruby_method_name = to_underscore(java_method.name)

        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{ruby_method_name}(*arguments)
            ib_arguments = arguments.collect(&:to_ib)
            @ib_client.#{java_method.name} *ib_arguments
          end
        RUBY
      end

      EClient.java_class.declared_instance_methods.each do |java_method|
        define_ruby_method_for(java_method)
      end
    end
  end
end
