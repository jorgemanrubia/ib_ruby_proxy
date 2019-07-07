java_import 'com.ib.client.EWrapper'
require 'drb/observer'

module IbRubyProxy
  module Server
    # Ruby representation of the IB +EWrapper+ class. It delegates received callbacks by
    # triggering an observer notification. It will translate the name of the java method to
    # Ruby (underscore), as well as translate the parameters from IB to the Ruby world.
    #
    # @see IbClientAdapter
    class IbWrapperAdapter
      # include DRb::DRbObservable
      include EWrapper
      include DRb::DRbObservable
      include IbRubyProxy::Util::HasLogger
      extend IbRubyProxy::Util::StringUtils

      attr_reader :signal, :client

      def initialize
        @signal = EJavaSignal.new
        @client = EClientSocket.new(self, @signal)
      end

      # @private
      def self.define_ruby_method_for(java_method)
        ruby_method_name = to_underscore(java_method.name)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{java_method.name}(*arguments)
            ruby_arguments = arguments.collect(&:to_ruby)
            if count_observers > 0
              changed
              notify_observers *(["#{ruby_method_name}"] + ruby_arguments)
            else
              logger.debug "Received #{ruby_method_name}"
              logger.debug ruby_arguments.inspect
            end
          end
        RUBY
      end

      EWrapper.java_class.declared_instance_methods.each do |java_method|
        define_ruby_method_for(java_method)
      end
    end
  end
end
