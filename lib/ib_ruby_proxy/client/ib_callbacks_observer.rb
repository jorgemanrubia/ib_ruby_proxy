module IbRubyProxy
  module Client
    # Base observer for callbacks received by {IbRubyProxy::Server::IbWrapperAdapter}
    #
    # This class is meant to be extended by implementing the methods for the callbacks you
    # are interested in
    class IbCallbacksObserver
      include IbRubyProxy::Util::HasLogger

      # This is the ruby equivalent to Interactive Brokers EWrapper class. Extend it and add the methods
      # you want to respond to.
      include DRb::DRbUndumped

      def update(*params)
        method_name, *arguments = params
        send method_name, *arguments
      end

      def error(*arguments)
        logger.error 'Error received in ib wrapper:'
        logger.error arguments.inspect
      end
    end
  end
end
