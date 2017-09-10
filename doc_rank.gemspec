# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "doc_rank/version"

Gem::Specification.new do |spec|
  spec.name          = "doc_rank"
  spec.version       = DocRank::VERSION
  spec.authors       = ["s1v4", "sergeg"]
  spec.email         = ["hdao61@gmail.com", "sergeyganous@gmail.com"]

  spec.summary       = %q{Returns a similarity score between one or many documents against a base document (keyword comparison).}
  spec.homepage      = "https://github.com/S1v4/doc_rank"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.4'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "highscore", "~> 1.2.1"
  spec.add_runtime_dependency "yomu", "~> 0.2.4"
  spec.add_development_dependency "yard", "~> 0.9.9"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry-nav"
end
