require 'spec_helper'
require 'net/http'


describe 'mock server' do
  let( :http ) { Net::HTTP.new('127.0.0.1', 3000) }
  let( :http2 ) { Net::HTTP.new('127.0.0.1', 4000) }

  it "should work" do
    server = mock_server(3000) do
      get '/user' do
        'hello'
      end
    end

    server.run do
      http.request_get('/user').body.should eq("hello")
    end
  end

  it "should work as well" do
    server = mock_server(3000) do
      get '/category' do
        'hello'
      end
    end

    server.run do
      http.request_get('/category').body.should eq("hello")
    end
  end

  it "should work as well 2" do
    server = mock_server(4000) do
      get '/category' do
        'hello'
      end
    end

    server.run do
      http2.request_get('/category').body.should eq("hello")
    end
  end
end

