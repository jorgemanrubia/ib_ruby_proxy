module IbRubyProxy
  module Util
    # Mixin to add access to the gem logger
    module HasLogger
      def logger
        @logger ||= IbRubyProxy.logger
      end
    end
  end
end
