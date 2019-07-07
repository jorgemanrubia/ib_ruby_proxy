module Test
  module IbRubyProxyHelpers
    IMPERSONATED_METHODS = %i[req_contract_details req_historical_ticks req_historical_data]

    def build_impersonated_client
      Impersonator.impersonate(*IMPERSONATED_METHODS) { IbRubyProxy::Client::Client.from_drb }
          .tap do |impersonated_client|
        impersonated_client.configure_method_matching_for(:req_contract_details) do |config|
          config.ignore_arguments_at 0
        end
      end
    end
  end
end
