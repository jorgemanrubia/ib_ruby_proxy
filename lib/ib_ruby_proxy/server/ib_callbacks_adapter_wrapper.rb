java_import 'com.ib.client.EWrapper'
require 'drb/observer'

# Let's mame more generic with EWrapper.java_class.declared_instance_methods
module IbRubyProxy
  module Server
    class IbCallbacksAdapterWrapper
      # include DRb::DRbObservable
      include EWrapper
      include DRb::DRbObservable
      extend IbRubyProxy::Util::StringUtils

      attr_reader :signal, :client
      attr_accessor :ib_callbacks_wrapper

      def initialize
        @signal = EJavaSignal.new
        @client = EClientSocket.new(self, @signal)
      end

      EWrapper.java_class.declared_instance_methods.each do |java_method|
        ruby_method_name = to_underscore(java_method.name)

        class_eval <<-RUBY
          def #{java_method.name}(*arguments)
            ruby_arguments = arguments.collect(&:to_ruby)
            if ib_callbacks_wrapper
              ib_callbacks_wrapper&.notify_observers "#{ruby_method_name}", *ruby_arguments
            else
              handle_callback_when_no_wrapper("#{ruby_method_name}", *ruby_arguments)
            end
          end

          def handle_callback_when_no_wrapper(method_name, *arguments)
puts "*" 
puts "RECEIVED"
puts method_name
puts arguments
raise arguments.last if arguments.last.respond_to?(:backtrace)

puts "*" 
            # name, rest_of_arguments = arguments
            # puts name
            # puts rest_of_arguments
          end
        RUBY
      end
    end

  end
end
