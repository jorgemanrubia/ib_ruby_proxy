module IbRubyProxy
  module Client
    class CallbacksResponseHandler
      IB_CALLBACKS_MAPPING = {
          req_historical_ticks: { callbacks: %i(historical_ticks historical_ticks_bid_ask historical_ticks_last), discriminate_by_argument_nth: 0 },
          req_contract_details: { callbacks: %i(contract_details contract_details_end), discriminate_by_argument_nth: 0 },
          req_tick_by_tick_data: { callbacks: %i(tick_by_tick_bid_ask tick_by_tick_all_last tick_by_tick_mid_point), discriminate_by_argument_nth: 0 }
      }

      def initialize
        @method_handlers = {}
        @callback_handlers = {}
      end

      def method_invoked(method_name, *arguments, &block)
        method_name = method_name.to_sym
        method_handlers[method_name]&.method_invoked(*arguments, &block)
      end

      def callback_received(callback_name, *arguments)
        callback_name = callback_name.to_sym
        callback_handlers[callback_name]&.callback_received(callback_name, *arguments)
      end

      # @todo: Move outside of this class when we add more options
      def self.for_ib
        self.new.tap do |handler|
          IB_CALLBACKS_MAPPING.each do |method, callback_config|
            handler.configure_block_callback method: method.to_sym,
                                             callback: callback_config[:callbacks],
                                             discriminate_by_argument_nth: callback_config[:discriminate_by_argument_nth]
          end
        end
      end

      def configure_block_callback(method:, callback:, discriminate_by_argument_nth: nil)
        validate_can_add_callback_on_method!(method)

        handler = CallbackResponseHandler.new(discriminate_by_argument_nth)

        configure_callback_handler(callback, handler)
        configure_method_handler(method, handler)
      end

      private

      attr_reader :method_handlers, :callback_handlers

      def configure_method_handler(method, handler)
        method_handlers[method.to_sym] = handler
      end

      def configure_callback_handler(callback, handler)
        callback = [callback] unless callback.respond_to?(:each)
        callback << :error
        callback.each do |callback_name|
          callback_handlers[callback_name.to_sym] = handler
        end
      end

      def validate_can_add_callback_on_method!(method)
        raise "Already configured handler for #{method}" if method_handlers[method]
      end

      class CallbackResponseHandler
        include IbRubyProxy::Util::HasLogger

        attr_reader :discriminate_by_argument_nth, :block

        def initialize(discriminate_by_argument_nth)
          @discriminate_by_argument_nth = discriminate_by_argument_nth
          @blocks_by_discriminator = {}
        end

        def method_invoked(*arguments, &block)
          if @discriminate_by_argument_nth
            discrminator = arguments[@discriminate_by_argument_nth]
            raise "No argument #{@discriminate_by_argument_nth} to discriminate with? #{arguments.inspect}" unless discrminator
            @blocks_by_discriminator[discrminator] = block
          else
            @block = block
          end
          nil
        end

        def callback_received(callback_name, *arguments)
          if callback_name.to_s == 'error'
            raise StandardError, arguments.join('. ')
          else
            block = if @discriminate_by_argument_nth
                      @blocks_by_discriminator[arguments[@discriminate_by_argument_nth]]
                    else
                      @block
                    end

            block&.call(callback_name, *arguments)
          end
        end
      end
    end
  end
end
