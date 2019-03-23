module IbRubyProxy
  module Client
    class IbCallbacksWrapper
      include IbRubyProxy::Util::HasLogger

      # This is the ruby equivalent to Interactive Brokers EWrapper class. Extend it and add the methods
      # you want to respond to.
      include DRb::DRbUndumped

      def update(*params)
        method_name, *arguments = params
        send method_name, *arguments
      end

      def error(*arguments)
        logger.error "Error received in ib wrapper:"
        logger.error arguments.inspect
      end

    end
  end
end
