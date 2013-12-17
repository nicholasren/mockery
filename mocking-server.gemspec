Gem::Specification.new do |s|
  s.name        = "mocking-server"
  s.version     = "0.0.1"
  s.summary     = %{A quick way of mocking an external web service you want to consume.}
  s.description = ""
  s.authors     = ["Nicholas Ren"]
  s.email       = ["nicholas85211@gmail.com"]
  s.homepage    = "http://github.com/nicholasren/mocking-server"
  s.files       = ['lib/mocking_server.rb', 'README.md', 'LICENSE', 'spec/mocking_server_spec.rb']
  s.add_dependency "sinatra"
end
