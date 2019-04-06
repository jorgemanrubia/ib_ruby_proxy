module IbRubyProxy
  module Client
    class CallbacksResponseHandler
      def initialize
        @method_handlers = {}
        @callback_handlers = {}
      end

      def method_invoked(method_name, *arguments)
        method_name = method_name.to_sym
        method_handlers[method_name]&.method_invoked(*arguments)
      end

      def callback_received(callback_name, *arguments)
        callback_name = callback_name.to_sym
        callback_handlers[callback_name]&.callback_received(*arguments, callback_name: callback_name)
      end

      # @todo: Move outside of this class when we add more options
      def self.for_ib
        self.new.tap do |handler|
          handler.configure_single_response_promise_callback method: :req_historical_ticks,
                                                             callback: %i(historical_ticks historical_ticks_bid_ask historical_ticks_last),
                                                             discriminate_by_argument_nth: 0

          handler.configure_multi_response_promise_callback method: :req_contract_details,
                                                            callback: :contract_details,
                                                            done_callback: :contract_details_end,
                                                            discriminate_by_argument_nth: 0
        end
      end

      def configure_single_response_promise_callback(method:, callback:, discriminate_by_argument_nth: 0)
        raise "Already configured handler for #{method}" if method_handlers[method]

        handler = PromiseSingleResponseHandler.new(discriminate_by_argument_nth)

        configure_callback_handler(callback, handler)
        configure_method_handler(method, handler)
      end

      def configure_multi_response_promise_callback(method:, callback:, done_callback:, discriminate_by_argument_nth: 0)
        raise "Already configured handler for #{method}" if method_handlers[method]

        handler = PromiseMultipleResponseHandler.new(discriminate_by_argument_nth, done_callback)

        configure_callback_handler(callback, handler)
        configure_callback_handler(done_callback, handler)
        configure_method_handler(method, handler)
      end

      private

      attr_reader :method_handlers, :callback_handlers

      def configure_method_handler(method, handler)
        method_handlers[method.to_sym] = handler
      end

      def configure_callback_handler(callback, handler)
        callback = [callback] unless callback.respond_to?(:each)
        callback.each do |callback_name|
          callback_handlers[callback_name.to_sym] = handler
        end
      end

      class PromiseSingleResponseHandler
        attr_reader :discriminate_by_argument_nth, :promise

        def initialize(discriminate_by_argument_nth)
          @discriminate_by_argument_nth = discriminate_by_argument_nth
          @promises_by_key = {}
        end

        def method_invoked(*arguments)
          key = arguments[discriminate_by_argument_nth]
          raise "Configured with a promise and invoked more than once?" if @promises_by_key[key]
          @promises_by_key[key] = Concurrent::Promises.resolvable_future
        end

        def callback_received(*arguments)
          key = arguments[discriminate_by_argument_nth]
          @promises_by_key[key]&.fulfill arguments
        end
      end

      class PromiseMultipleResponseHandler
        attr_reader :discriminate_by_argument_nth, :promise, :done_callback

        def initialize(discriminate_by_argument_nth, done_callback)
          @discriminate_by_argument_nth = discriminate_by_argument_nth
          @done_callback = done_callback
          @promises_by_key = {}
          @results = []
        end

        def method_invoked(*arguments)
          key = arguments[discriminate_by_argument_nth]
          raise "Configured with a promise and invoked more than once?" if @promises_by_key[key]
          @promises_by_key[key] = Concurrent::Promises.resolvable_future
        end

        def callback_received(*arguments, callback_name: callback_name)
          key = arguments[discriminate_by_argument_nth]
          if callback_name == done_callback
            @promises_by_key[key]&.fulfill @results
          else
            @results << arguments
          end
        end
      end
    end
  end
end
