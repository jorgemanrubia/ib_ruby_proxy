require 'ib_ruby_proxy/version'
require_relative 'ib_wrapper_adapter'
require_relative 'ib_client_adapter'
require 'drb'

java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EJavaSignal'
java_import 'com.ib.client.EClientSocket'
java_import 'com.ib.client.EReader'

module IbRubyProxy
  module Server
    # Proxy service for invoking IB api through
    # {https://ruby-doc.org/stdlib-2.6.1/libdoc/drb/rdoc/DRb.html DRb}
    #
    # The proxy does essentially 2 things:
    #
    # * Starts a DRb process you can connect to invoke the IB api. This will expose an {IbClientAdapter}
    #   object to its clients
    # * Starts an IB message-processing thread that will dispatch messages sent to IB client app (
    #   gateway or TWS)
    class IbProxyService
      DEFAULT_IB_HOST = 'localhost'
      DEFAULT_IB_GATEWAY_PORT = 4002
      DEFAULT_DRB_HOST = 'localhost'
      DEFAULT_DRB_PORT = 1992

      # @param [String] ib_host Hostname for the IB client app (gateway or TWS). Default +localhost+
      # @param [Integer] ib_port Port for hte IB client app (gateway or TWS). Default +4002+ (gateway)
      # @param [String] drb_host Hostname for the DRB process. Default +localhost+
      # @param [Integer] drb_port Port for the . Default +1992+
      def initialize(ib_host: DEFAULT_IB_HOST, ib_port: DEFAULT_IB_GATEWAY_PORT,
                     drb_host: DEFAULT_DRB_HOST, drb_port: DEFAULT_DRB_PORT)
        @ib_host = ib_host
        @ib_port = ib_port
        @drb_host = drb_host
        @drb_port = drb_port

        @wrapper = IbRubyProxy::Server::IbWrapperAdapter.new
        @client = wrapper.client
        @signal = wrapper.signal

        connect
      end

      # Connects to IB and starts the DRb process
      #
      # Clients of the DRb service will get an {IbClientAdapter} object to interact with the IB api
      # @return [void]
      def start
        DRb.start_service("druby://#{drb_host}:#{drb_port}", ib_client_adapter, verbose: true)
        start_ib_message_processing_thread
        puts "Ib proxy server started at druby://#{drb_host}:#{drb_port}. Connected to IB at"\
             " #{ib_host}:#{ib_port}"
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
              reader.processMsgs
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
        @ib_client_adapter ||= IbRubyProxy::Server::IbClientAdapter.new(client, wrapper)
      end
    end
  end
end
