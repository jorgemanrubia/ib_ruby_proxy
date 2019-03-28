require 'drb/timeridconv'

module IbRubyProxy
  module Client
    class Client
      attr_reader :ib_client

      def self.from_drb(host: 'localhost', port: 1992)
        self.new(ib_client: create_drb_ib_client(host: host, port: port))
      end

      def initialize(ib_client)
        @ib_client = ib_client
        @promises_by_request_id = {}
        @ib_client.add_ib_callbacks_observer PromiseResolverCallbackWrapper.new(@promises_by_request_id)
      end

      # We want to keep method_missing only for ib_methods...
      def add_ib_callbacks_observer(client_ib_callbacks_wrapper)
        @ib_client.add_ib_callbacks_observer(client_ib_callbacks_wrapper)
      end

      private

      def create_drb_ib_client(host:, port:)
        drb_ib_client = DRbObject.new(nil, "druby://#{host}:#{port}")
        DRb::DRbServer.verbose = true
        DRb.install_id_conv ::DRb::TimerIdConv.new 60
        DRb.start_service
        drb_ib_client
      end

      def respond_to_missing?(name, include_private = false)
        @ib_client.respond_to?(name, include_private)
      end

      def method_missing(method, *args, &block)
        promise = Concurrent::Promises.resolvable_future
        request_id = args.first
        @promises_by_request_id[request_id] = promise
        @ib_client.public_send(method, *args, &block)
        promise
      end

      class PromiseResolverCallbackWrapper
        include IbRubyProxy::Util::HasLogger

        include DRb::DRbUndumped

        attr_reader :promises_by_request_id

        def initialize(promises_by_request_id)
          @promises_by_request_id = promises_by_request_id
        end

        def update(*params)
          _, *arguments = params
          request_id = arguments.first
          promise = promises_by_request_id[request_id]
          promise.fulfill(arguments)
          promises_by_request_id.delete request_id
        end
      end
    end
  end
end
