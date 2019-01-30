require "ib_ruby_proxy/version"

Dir["#{__dir__}/ib_ruby_proxy/client/**/*.rb"].each {|file| require file }

module IbRubyProxy
  class Error < StandardError;
  end
end
