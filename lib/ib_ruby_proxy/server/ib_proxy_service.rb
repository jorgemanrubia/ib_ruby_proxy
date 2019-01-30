require "ib_ruby_proxy/version"
require_relative '../../../vendor/TwsApi.jar'
require_relative 'ib_callbacks_wrapper'
require_relative 'ib_client_adapter'
require 'drb'

java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EJavaSignal'
java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EReader'

module IbRubyProxy
  module Server
    class IbProxyService
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
        DRb.start_service("druby://#{drb_host}:#{drb_port}", ib_client_adapter)
        start_ib_message_processing_thread
        puts "Ib proxy server started at druby://#{drb_host}:#{drb_port}. Connected to IB at #{ib_host}:#{ib_port}"
        DRb.thread.join
      end

      private

      attr_reader :wrapper, :client, :signal, :ib_host, :ib_port, :drb_host, :drb_port

      def start_ib_message_processing_thread
        reader = EReader.new(client, signal)
        reader.start

        Thread.new do
          while client.isConnected
            signal.waitForSignal
            begin
              reader.processMsgs();
            rescue StandardError => e
              puts "Error while processing ib message: #{e}"
            end
          end
        end
      end

      def connect
        client.eConnect(ib_host, ib_port, 2)
      end

      def ib_client_adapter
        @ib_client_adapter ||= IbRubyProxy::Server::IbClientAdapter.new(client)
      end
    end
  end
end
