require_relative 'converts_ruby_to_ib'

module IbRubyProxy
  module Server
    class IbClientAdapter
      include ConvertsRubyToIb

      attr_reader :ib_client

      def initialize(ib_client)
        @ib_client = ib_client
      end

      # void reqHistoricalTicks	(	int reqId,
      # Contract 	contract,
      # string 	startDateTime,
      # string 	endDateTime,
      # int 	numberOfTicks,
      # string 	whatToShow,
      # int 	useRth,
      # bool 	ignoreSize,
      # List< TagValue > 	miscOptions
      # )
      def req_historical_ticks(request_id, contract, start_date_time, end_date_time, number_of_ticks, what_to_show, use_rth,
                             ignore_size, misc_options)

        puts "Se recibe original: #{contract}}"
        puts "Se recibe: #{as_ib_contract(contract)}"
        ib_client.reqHistoricalTicks(request_id, as_ib_contract(contract), start_date_time, end_date_time, number_of_ticks, what_to_show,
                                     use_rth, ignore_size, misc_options)
      end

    end
  end
end

