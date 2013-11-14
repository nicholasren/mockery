Gem::Specification.new do |s|
  s.name        = "mockery"
  s.version     = "0.0.1"
  s.summary     = %{A quick way of mocking an external web service you want to consume.}
  s.authors     = ["Nicholas Ren"]
  s.email       = ["nicholas85211@gmail.com"]
  s.homepage    = "http://github.com/nicholasren/mock-server"
  s.files       = ["lib/mockery.rb", "README.markdown", "spec/mockery_spec.rb", 'spec/spec_helper.rb']
  s.add_dependency "sinatra"
end
