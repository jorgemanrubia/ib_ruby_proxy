describe IbRubyProxy::Client::CallbacksResponseHandler do
  describe 'Promises' do
    subject(:callbacks_response_handler) { IbRubyProxy::Client::CallbacksResponseHandler.new }
    let(:client) { double 'dummy client', callbacks_response_handler: callbacks_response_handler, error: nil }

    describe '#configure_block_callback' do
      let(:proc) { ->{} } # getting stackoverflow error with proc{} so using a lambda instead

      it 'allows handling callbacks invoking a block with each response' do
        callbacks_response_handler.configure_block_callback method: :some_method,
                                                            callback: :response_callback,
                                                            discriminate_by_argument_nth: 0

        def client.some_method(id, name, &block)
          callbacks_response_handler.method_invoked(:some_method, id, name, &block)
        end

        client.some_method(1, 'some param', &proc)

        expect(proc).to receive(:call).with(:response_callback, 1, 'value 1-1', 'value 1-2').ordered
        expect(proc).to receive(:call).with(:response_callback, 1, 'value 1-3', 'value 1-4').ordered
        expect(proc).to receive(:call).with(:response_callback, 2, 'value 2-1', 'value 2-2').ordered

        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1-1', 'value 1-2')
        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1-3', 'value 1-4')
        callbacks_response_handler.callback_received(:response_callback, 2, 'value 2-1', 'value 2-2')
      end

      it 'triggers an exception when the error callback is invoked' do
        callbacks_response_handler.configure_block_callback method: :some_method,
                                                            callback: :error,
                                                            discriminate_by_argument_nth: 0

        expect{ callbacks_response_handler.callback_received(:error, 'some', 'error')}.to raise_error('some. error')
      end
    end


  end
end
