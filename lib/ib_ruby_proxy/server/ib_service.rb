require "ib_ruby_proxy/version"
require_relative '../../../vendor/TwsApi.jar'
require 'drb'
require_relative 'ib_callbacks_wrapper'

java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EJavaSignal'
java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EReader'
java_import 'com.ib.client.Contract'

module IbRubyProxy
  module Server
    class IbService
      DEFAULT_IB_GATEWAY_PORT = 4002
      DEFAULT_DRB_PORT = 1992

      def initialize(ib_host: 'localhost', ib_port: DEFAULT_IB_GATEWAY_PORT,
                     drb_host: 'localhost', drb_port: DEFAULT_DRB_PORT)
        @ib_host = ib_host
        @ib_port = ib_port
        @drb_host = drb_host
        @drb_port = drb_port

        @wrapper = IbRubyProxy::Server::IbCallbacksWrapper.new
        @client = wrapper.client
        @signal = wrapper.signal

        connect()
      end

      def start
        DRb.start_service("druby://#{drb_host}:#{drb_port}", client)
        start_ib_message_processing_thread
        puts "Ib proxy server started at druby://#{drb_host}:#{drb_port}. Connected to IB at #{ib_host}:#{ib_port}"
        DRb.thread.join
      end

      private

      def start_ib_message_processing_thread
        reader = EReader.new(client, signal)
        reader.start

        Thread.new do
          while client.isConnected
            signal.waitForSignal
            begin
              reader.processMsgs();
            rescue e
              puts "Error catched: #{e}"
            end
          end
        end
      end

      def connect
        client.eConnect(ib_host, ib_port, 2)
      end

      attr_reader :wrapper, :client, :signal, :ib_host, :ib_port, :drb_host, :drb_port
    end
  end
end
