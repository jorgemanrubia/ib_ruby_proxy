require "ib_ruby_proxy/version"
require_relative '../vendor/TwsApi.jar'

Dir["#{__dir__}/ib_ruby_proxy/server/**/*.rb"].each {|file| require file }
