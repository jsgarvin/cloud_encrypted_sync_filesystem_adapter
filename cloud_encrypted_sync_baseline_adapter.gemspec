require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "cloud_encrypted_sync_baseline_adapter"
  s.version = CloudEncryptedSyncBaselineAdapter::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["**YOUR NAME**"]
  s.email = ["**YOUR EMAIL**"]
  s.homepage = "https://github.com/**YOU**/cloud_encrypted_sync_baseline_adapter"
  s.summary = %q{Baseline adapter plugin for CloudEncryptedSync gem.}
  s.description = %q{Baseline adapter plugin for CloudEncryptedSync gem.}

  s.add_dependency('cloud_encrypted_sync')

  s.add_development_dependency('rake')
  s.add_development_dependency('mocha')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('activesupport')

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end