require './lib/mocking_server'

RSpec.configure do |config|
  config.include MockingServer::Methods
end

