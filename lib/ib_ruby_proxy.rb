require 'ib_ruby_proxy/version'
require 'awesome_print'
require 'drb'

Dir["#{__dir__}/ib_ruby_proxy/client/**/*.rb"].each {|file| require file }
Dir["#{__dir__}/ib_ruby_proxy/util/**/*.rb"].each {|file| require file }

module IbRubyProxy
  class Error < StandardError;
  end
end
