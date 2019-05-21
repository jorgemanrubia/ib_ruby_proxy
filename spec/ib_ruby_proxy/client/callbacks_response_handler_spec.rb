describe IbRubyProxy::Client::CallbacksResponseHandler do
  describe 'Promises' do
    subject(:callbacks_response_handler) { IbRubyProxy::Client::CallbacksResponseHandler.new }
    let(:client) { double 'dummy client', callbacks_response_handler: callbacks_response_handler }

    describe '#configure_single_response_promise_callback' do
      it 'allows handling callbacks as promises by matching them via a param' do
        callbacks_response_handler.configure_single_response_promise_callback method: :some_method,
                                                                              callback: :response_callback,
                                                                              discriminate_by_argument_nth: 0

        def client.some_method(id, name)
          callbacks_response_handler.method_invoked(:some_method, id, name)
        end

        promise = client.some_method(1, 'some param')
        expect(promise).not_to be_resolved

        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1', 'value 2')

        expect(promise).to be_resolved
        expect(promise.value).to eq([1, 'value 1', 'value 2'])
      end
    end

    describe '#configure_multi_response_promise_callback' do
      it 'allows handling multiple callbacks and collecting the results until a finish callback is invoked' do
        callbacks_response_handler.configure_multi_response_promise_callback method: :some_method,
                                                                             done_callback: :done,
                                                                             callback: :response_callback,
                                                                             discriminate_by_argument_nth: 0

        def client.some_method(id, name)
          callbacks_response_handler.method_invoked(:some_method, id, name)
        end

        promise = client.some_method(1, 'some param')
        expect(promise).not_to be_resolved

        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1-1', 'value 1-2')
        callbacks_response_handler.callback_received(:response_callback, 1, 'value 2-1', 'value 2-2')
        callbacks_response_handler.callback_received(:done, 1)

        expect(promise).to be_resolved
        expect(promise.value).to eq([[1, 'value 1-1', 'value 1-2'], [1, 'value 2-1', 'value 2-2']])
      end
    end

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

        expect(proc).to receive(:call).with(1, 'value 1-1', 'value 1-2').ordered
        expect(proc).to receive(:call).with(1, 'value 1-3', 'value 1-4').ordered
        expect(proc).to receive(:call).with(2, 'value 2-1', 'value 2-2').ordered

        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1-1', 'value 1-2')
        callbacks_response_handler.callback_received(:response_callback, 1, 'value 1-3', 'value 1-4')
        callbacks_response_handler.callback_received(:response_callback, 2, 'value 2-1', 'value 2-2')
      end
    end


  end
end
