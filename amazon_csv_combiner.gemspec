
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "amazon_csv_combiner/version"

Gem::Specification.new do |spec|
  spec.name          = "amazon_csv_combiner"
  spec.version       = AmazonCsvCombiner::VERSION
  spec.authors       = ["John Randall"]
  spec.email         = ["john@johnrandall.com"]

  spec.summary       = %q{Combine and Amazon orders csv and items csv into a csv suitable for importing into a financial ledger.}
  spec.description   = %q{Takes and Amazon orders csv and items csv as input. Generates and output csv suitable for importing into a financial program.}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", 'lib/**']

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "pry"
  spec.add_dependency 'thor'
end
