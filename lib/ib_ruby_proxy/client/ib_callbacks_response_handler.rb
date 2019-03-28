module IbRubyProxy
  module Client
    class IbCallbacksResponseHandler
      def initialize
        @method_handlers = {}
        @callback_handlers = {}
      end

      def configure_promise_callback(method:, callback:, discriminate_by_argument_nth: 0)
        raise "Already configured handler for #{method}" if method_handlers[method]

        handler = PromiseResponseHandler.new(discriminate_by_argument_nth)

        configure_callback_handler(callback, handler)
        configure_method_handler(method, handler)
      end

      def method_invoked(method_name, *arguments)
        method_handlers[method_name]&.method_invoked(*arguments)
      end

      def callback_received(callback_name, *arguments)
        callback_handlers[callback_name]&.callback_received(*arguments)
      end

      private

      attr_reader :method_handlers, :callback_handlers

      def configure_method_handler(method, handler)
        method_handlers[method] = handler
      end

      def configure_callback_handler(callback, handler)
        callback = [callback] unless callback.respond_to?(:each)
        callback.each do |callback_name|
          callback_handlers[callback_name] = handler
        end
      end

      class PromiseResponseHandler
        attr_reader :discriminate_by_argument_nth, :promise

        def initialize(discriminate_by_argument_nth)
          @discriminate_by_argument_nth = discriminate_by_argument_nth
        end

        def method_invoked(*arguments)
          raise "Configured with a promise and invoked more than once?" if @promise
          @promise = Concurrent::Promises.resolvable_future
        end

        def callback_received(*arguments)
          @promise.fulfill arguments
        end
      end
    end
  end
end
