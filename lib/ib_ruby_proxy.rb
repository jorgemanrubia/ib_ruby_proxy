require 'ib_ruby_proxy/version'
require 'awesome_print'
require 'drb'
require 'logger'
require 'concurrent-ruby'
require 'yaml'

Dir["#{__dir__}/ib_ruby_proxy/util/**/*.rb"].each { |file| require file }
Dir["#{__dir__}/ib_ruby_proxy/client/**/*.rb"].each { |file| require file }

module IbRubyProxy
  LOGGER_LEVEL = Logger::DEBUG

  # Gem logger
  #
  # @return [Logger]
  def self.logger
    @logger ||= Logger.new(STDOUT).tap do |logger|
      logger.level = LOGGER_LEVEL
    end
  end

  # Configuration options parsed from +ib_ruby_proxy/config.yml+
  #
  # @return [Hash]
  def self.config
    @config ||= begin
      file_path = File.join(__dir__, 'ib_ruby_proxy/config.yml')
      YAML.load_file(file_path)
    end
  end

  class Error < StandardError
  end
end
