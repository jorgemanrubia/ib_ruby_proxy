describe IbRubyProxy::Client::IbCallbacksWrapper do
  class MyDummyWrapper < IbRubyProxy::Client::IbCallbacksWrapper
    def my_dummy_method(argument_1, argument_2); end
  end

  it 'responds to `update` invoking the method received in the arguments' do
    wrapper = MyDummyWrapper.new
    expect(wrapper).to receive(:my_dummy_method).with(12, 34)
    wrapper.update :my_dummy_method, 12, 34
  end
end
