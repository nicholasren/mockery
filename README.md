# Mockery #
A quick way of mocking an external web service you want to consume.
Inspired by [moco](https://github.com/dreamhead/moco), [mock-server](https://github.com/djanowski/mock-server) and [sinatra](http://www.sinatrarb.com/)

# Why #
Integration, especially based on HTTP, e.g. web service, REST etc, is widlly used in most web development.
When you write a feature that need to connect to an external web service
You wonder how to test that. One option is to stub methods in Net::HTTP and equivalents, but by doing that you
are tying yourself to an implementation detail. The ideal thing is to have a server running locally, Then serve different request for different response.

One thing I want to highlight is, rather than set up a global server which respond to all coming request, With `mockery`, you can set up different server for different `testcase`, `spec` or `scenario`.

## Feature ##
+ Standalone server, test the real interaction.
+ Setup your mock server with sinatra's elegant DSL.

## Get it ##

`gem install mockery` or add `gem 'mockery'` in your `Gemfile`

## With rspec ##

```
  # in rspec helper
  require 'mockery'
  RSpec.configure do |config|
    config.include Mockery::Methods
  end

  # in spec
  describe ApiCilent do
    subject { ApiCilent.new }

    it "should return hello" do
      server = mock_server do
        get '/greeting' do
          status 200
          body 'hello'
        end
      end

      server.run do
        expect(subject.greeting).to eq('hello')
      end
    end
  end
```

### With cucumber ##

```
  #in env.rb
  require 'mockery'
  World(Mockery::Methods)


  # in steps
  server = mock_server do
    get '/greeting' do
      status 200
      body 'hello'
    end
  end

  server.run do
    # steps that send request to the local mock sever
  end
```

## License ##

MIT.

## Contributor

+ Niu Yameng
+ Nicholas Ren
