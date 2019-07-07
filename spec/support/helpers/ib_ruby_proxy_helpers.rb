module Test
  module IbRubyProxyHelpers
    def build_impersonated_client
      Impersonator.impersonate(:req_contract_details) { IbRubyProxy::Client::Client.from_drb }
          .tap do |impersonated_client|
        impersonated_client.configure_method_matching_for(:req_contract_details) do |config|
          config.ignore_arguments_at 0
        end
      end
    end
  end
end
