require File.expand_path('../lib/cloud_encrypted_sync_filesystem_adapter/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "cloud_encrypted_sync_filesystem_adapter"
  s.version = CloudEncryptedSyncFilesystemAdapter::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jonathan S. Garvin"]
  s.email = ["jon@5valleys.com"]
  s.homepage = "https://github.com/jsgarvin/cloud_encrypted_sync_filesystem_adapter"
  s.summary = %q{Plugin adapter for CloudEncryptedSync gem that stores encrypted backups to the local filesystem.}
  s.description = %q{Plugin adapter for CloudEncryptedSync gem that provides stores to the local filesystem.}

  s.add_dependency('cloud_encrypted_sync', '~> 0.1.2')

  s.add_development_dependency('rake')
  s.add_development_dependency('mocha')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('activesupport')

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end