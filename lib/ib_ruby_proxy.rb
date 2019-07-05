require 'ib_ruby_proxy/version'
require 'awesome_print'
require 'drb'
require 'logger'
require 'concurrent-ruby'

Dir["#{__dir__}/ib_ruby_proxy/util/**/*.rb"].each { |file| require file }
Dir["#{__dir__}/ib_ruby_proxy/client/**/*.rb"].each { |file| require file }

module IbRubyProxy
  LOGGER_LEVEL = Logger::DEBUG

  def self.logger
    @logger ||= Logger.new(STDOUT).tap do |logger|
      logger.level = LOGGER_LEVEL
    end
  end

  class Error < StandardError
  end
end
