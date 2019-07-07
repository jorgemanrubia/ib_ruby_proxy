# IbRubyProxy

Service for invoking [Interactive Brokers (IB) api](https://www.interactivebrokers.com/en/index.php?f=5041) from Ruby.

`ib_ruby_proxy` acts as a mediator between your Ruby code and the IB software making the API calls ([Gateway](https://www.interactivebrokers.com/en/index.php?f=16457) or [TWS](https://www.interactivebrokers.com/en/index.php?f=16457)). Internally, it invokes the official IB Java API and translates objects between Ruby and Java worlds. It also translates method and callback names so that you can use Ruby convention (underscore) instead of Java's (camelcase).

By design, `ib_ruby_proxy` mimics the IB api design where, one entity is used to make all the api calls `EClient` and other entity is used to receive all the callback responses (`EWrapper`). Also, `ib_ruby_proxy` relies on the official [IB Java API implementation](https://interactivebrokers.github.io). Both decisions aim to increase the robustness of the approach, instead of making lower level api invocations through sockets or elaborated abstractions over how the API works.

The machine running the `ib_ruby_proxy` service needs JRuby installed. The clients of the service can use any standard Ruby distribution. Internally, it uses [DRb](https://ruby-doc.org/stdlib-2.6.3/libdoc/drb/rdoc/DRb.html) to communicate client and server.

![image-20190707102616973](/Users/jorge/work/ib_ruby_proxy/docs/images/architecture.png)

## Usage

### `ib_ruby_proxy` service

The service requires JRuby 9.2 or higher available in the system.

```
gem install ib_ruby_proxy
```

Start the process:

`ibproxy`

By default it will connect to the IB Gateway software at port `4002` and expose a DRb connection for clients at port `1992`. You can configure both with options `--ib-port` and `-drb-port`. Use `ibproxy help` to see the options available.

### Clients

Clients can use any Ruby distribution supporting DRb. This includes MRI and JRuby.

#### Plain approach

First, you instantiate a client object to make the api calls:

```ruby
client = IbRubyProxy::Client::Client.from_drb
```

Now you can use `client` to invoke api methods. It will use Ruby conventions so, for example, it would be `req_historical_ticks` instead of `reqHistoricalTicks`.

In order to receive callbacks, use a `IbRubyProxy::Client::IbCallbacksObserver` implementing the callback methods you want to handle. Again, callback names will use Ruby conventions.

For example, say you want to get the historical ticks for Apple (AAPL). IB api supports this with its [api method `reqHistoricalTicks` and a callback `historical_ticks` to receive the ticks](https://interactivebrokers.github.io/tws-api/historical_time_and_sales.html). The full example with `ib_ruby_proxy` looks like this:

```ruby
client = IbRubyProxy::Client::Client.from_drb

class CallbacksObserver < IbRubyProxy::Client::IbCallbacksObserver
  def historical_ticks(_request_id, ticks, _done)
    ap ticks
  end
end

aapl = IbRubyProxy::Client::Ib::Contract.new symbol: 'AAPL',
                                             sec_type: 'STK',
                                             exchange: 'ISLAND'

client.add_ib_callbacks_observer CallbacksObserver.new
client.req_historical_ticks(18009, aapl, '20190304 12:00:00', nil, 100,
                            'MIDPOINT', 1, false, nil)
```



#### Mapped callbacks

`ib_ruby_proxy` support passing a block to the api methods and have this block invoked with the corresponding received callbacks. The yielded params will include the callback name and the list of arguments received by the callback.

```ruby
client.req_historical_ticks(18009, aapl, nil, '20190304 17:00:00', 100,
                            'MIDPOINT', 1, false, nil) do |_callback, _request_id, ticks, _done|
  ap ticks
end
```

This feature is currently under development and not all the mappings have been configured yet. Please check section *Add custom mappings* if you want to contribute new mappings (pull requests welcomed).

## Development

### Add client classes

### Add custom mappings

### Tests

impersonator… promises

## Difference with ib-ruby

[ib-ruby](https://github.com/ib-ruby/ib-ruby) ...

`ib-ruby` has been around for a long time and it is well maintained. You should definitely give it a try if you are thinking in invoking IB from Ruby.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jorgemanrubia/ib_ruby_proxy.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
