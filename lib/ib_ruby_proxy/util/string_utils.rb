module IbRubyProxy
  module Util
    # String utility methods
    module StringUtils
      extend self

      # Makes passed string underscored and lowercase
      #
      # @param [String] string
      #
      # Implementation copied from Rails
      # @see https://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore
      def to_underscore(string)
        string.gsub(/::/, '/')
              .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
              .tr('-', '_')
              .downcase
      end

      # Converts passed string into camel case syntax
      #
      # @see https://stackoverflow.com/a/11411200/469697
      def to_camel_case(string)
        string.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
      end
    end
  end
end
