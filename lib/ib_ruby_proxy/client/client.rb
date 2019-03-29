require 'drb/timeridconv'

module IbRubyProxy
  module Client
    class Client
      attr_reader :ib_client

      def self.from_drb(host: 'localhost', port: 1992)
        self.new(create_drb_ib_client(host: host, port: port))
      end

      def initialize(ib_client)
        @ib_client = ib_client
        @promises_by_request_id = {}
        @callbacks_response_handler = CallbacksResponseHandler.for_ib
        @ib_client.add_ib_callbacks_observer ResponseHandleObserver.new(@callbacks_response_handler)
      end

      private

      def self.create_drb_ib_client(host:, port:)
        drb_ib_client = DRbObject.new(nil, "druby://#{host}:#{port}")
        DRb::DRbServer.verbose = true
        DRb.install_id_conv ::DRb::TimerIdConv.new 60
        DRb.start_service
        drb_ib_client
      end

      def respond_to_missing?(name, include_private = false)
        @ib_client.respond_to?(name, include_private)
      end

      def method_missing(method, *arguments, &block)
        @ib_client.public_send(method, *arguments, &block)
        @callbacks_response_handler.method_invoked method, *arguments
      end
    end

    class ResponseHandleObserver
      include DRb::DRbUndumped

      def initialize(callbacks_response_handler)
        @callbacks_response_handler = callbacks_response_handler
      end

      def update(*params)
        method, *arguments = params
        @callbacks_response_handler.callback_received(method, *arguments)
      end
    end
  end
end
