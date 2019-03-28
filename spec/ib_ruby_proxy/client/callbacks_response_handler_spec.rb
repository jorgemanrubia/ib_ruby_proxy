describe IbRubyProxy::Client::CallbacksResponseHandler do
  describe 'Promises' do
    subject(:callbacks_response_handler){IbRubyProxy::Client::CallbacksResponseHandler.new}
    let(:client){double 'dummy client', callbacks_response_handler: callbacks_response_handler}

    it 'allows handling callbacks as promises by matching them via a param' do
      callbacks_response_handler.configure_promise_callback method: :some_method, callback: :response_callback, discriminate_by_argument_nth: 0

      def client.some_method(id, name)
        callbacks_response_handler.method_invoked(:some_method, id, name)
      end

      promise = client.some_method(1, 'gregoria')
      expect(promise).not_to be_resolved

      callbacks_response_handler.callback_received(:response_callback, 1, 'value 1', 'value 2')

      expect(promise).to be_resolved
      expect(promise.value).to eq([1, 'value 1', 'value 2'])
    end
  end
end
