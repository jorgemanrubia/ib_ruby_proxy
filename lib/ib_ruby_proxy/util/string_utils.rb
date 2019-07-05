module IbRubyProxy
  module Util
    module StringUtils
      extend self

      # From rails
      def to_underscore(string)
        string.gsub(/::/, '/')
              .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
              .gsub(/([a-z\d])([A-Z])/, '\1_\2')
              .tr('-', '_')
              .downcase
      end

      # From https://stackoverflow.com/a/11411200/469697
      def to_camel_case(string)
        string.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
      end
    end
  end
end
