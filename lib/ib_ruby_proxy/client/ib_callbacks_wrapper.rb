
module IbRubyProxy
  module Client
    class IbCallbacksWrapper
      include DRb::DRbUndumped

      def update(*params)
        method_name, arguments = params
        send method_name, arguments
      end
    end
  end
end
