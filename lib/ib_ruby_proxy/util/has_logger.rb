module IbRubyProxy
  module Util
    module HasLogger
      def logger
        @logger ||= IbRubyProxy.logger
      end
    end
  end
end
