module IbRubyProxy
  module Client
    # This class maps callbacks with method invocations that originated them so that
    # a block can be passed to the api method and it will be invoked when a callback is
    # received
    class CallbacksResponseHandler
      def initialize
        @method_handlers = {}
        @callback_handlers = {}
      end

      # Handle invoked method
      #
      # @param [String, Symbol] method_name
      # @param [Array<Object>] arguments
      # @param [Proc] block
      def method_invoked(method_name, *arguments, &block)
        method_name = method_name.to_sym
        method_handlers[method_name]&.method_invoked(*arguments, &block)
      end

      # Handle callback received: it will invoke the block passed in the corresponding
      # {#method_invoked}, if any.
      #
      # @param [Symbol] callback_name
      # @param [Array<Object>] arguments
      def callback_received(callback_name, *arguments)
        callback_name = callback_name.to_sym
        callback_handlers[callback_name]&.callback_received(callback_name, *arguments)
      end

      # @private
      def self.for_ib
        new.tap do |handler|
          IbRubyProxy.config['mapped_callbacks'].each do |method, callback_config|
            nth_argument = callback_config['discriminate_by_argument_nth']
            handler.configure_block_callback method: method.to_sym,
                                             callbacks: callback_config['callbacks'],
                                             discriminate_by_argument_nth: nth_argument
          end
        end
      end

      # Configures a mapping between a method invocation and a received callback
      #
      # @param [String, Symbol] method
      # @param [String, Symbol] callbacks
      # @param [Integer, nil] discriminate_by_argument_nth The position of the argument that
      #   will be used to discriminate received callbacks and match them with invocation methods.
      #   +nil+ indicates no argument should be used for discriminating (default)
      def configure_block_callback(method:, callbacks:, discriminate_by_argument_nth: nil)
        validate_can_add_callback_on_method!(method)

        handler = BlockCallbackHandler.new(discriminate_by_argument_nth)

        configure_callbacks_handler(callbacks, handler)
        configure_method_handler(method, handler)
      end

      private

      attr_reader :method_handlers, :callback_handlers

      def configure_method_handler(method, handler)
        method_handlers[method.to_sym] = handler
      end

      def configure_callbacks_handler(callbacks, handler)
        callbacks << :error
        callbacks.each do |callback_name|
          callback_handlers[callback_name.to_sym] = handler
        end
      end

      def validate_can_add_callback_on_method!(method)
        raise "Already configured handler for #{method}" if method_handlers[method]
      end

      # b_proxy_service.rb:13@private
      class BlockCallbackHandler
        include IbRubyProxy::Util::HasLogger

        attr_reader :discriminate_by_argument_nth, :block

        def initialize(discriminate_by_argument_nth)
          @discriminate_by_argument_nth = discriminate_by_argument_nth
          @blocks_by_discriminator = {}
        end

        def method_invoked(*arguments, &block)
          if @discriminate_by_argument_nth
            discrminator = arguments[@discriminate_by_argument_nth]
            unless discrminator
              raise "No argument #{@discriminate_by_argument_nth} to discriminate with?"\
                    " #{arguments.inspect}"
            end

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
