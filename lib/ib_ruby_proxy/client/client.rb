module IbRubyProxy
  module Client
    class Client
      attr_reader :drb_client

      def initialize(host: 'localhost', port: 1992)
        @drb_client = DRbObject.new(nil, "druby://#{host}:#{port}")
        DRb::DRbServer.verbose = true
      end

      def connect
        DRb.start_service
      end

      private

      def respond_to_missing?(name, include_private = false)
        @drb_client.respond_to?(name, include_private)
      end

      def method_missing(method, *args, &block)
        @drb_client.public_send(method, *args, &block)
      end
    end
  end
end
