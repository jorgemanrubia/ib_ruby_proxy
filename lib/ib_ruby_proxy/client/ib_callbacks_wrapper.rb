module IbRubyProxy
  module Client
    class IbCallbacksWrapper
      include IbRubyProxy::Util::HasLogger

      # This is the ruby equivalent to Interactive Brokers EWrapper class. Extend it and add the methods
      # you want to respond to.
      include DRb::DRbUndumped

      def update(*params)
        method_name, *arguments = params
        logger.debug "Method received in wrapper: #{method_name}"
        send method_name, *arguments
      end
    end
  end
end
