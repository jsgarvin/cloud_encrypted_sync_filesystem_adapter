require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'active_support/test_case'
require 'test/unit'

SimpleCov.start

require 'cloud_encrypted_sync'
require 'cloud_encrypted_sync_filesystem_adapter'

module CloudEncryptedSyncFilesystemAdapter
  class ActiveSupport::TestCase

  end
end
require 'mocha'