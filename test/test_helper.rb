require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require 'fakefs/safe'
require 'active_support/test_case'
require 'test/unit'

SimpleCov.start

require 'cloud_encrypted_sync'
require 'cloud_encrypted_sync_filesystem_adapter'

module CloudEncryptedSyncFilesystemAdapter
  class ActiveSupport::TestCase

    setup :initialize_fake_fs
    teardown :deactivate_fake_fs

    #######
    private
    #######

    def initialize_fake_fs
      FakeFS.activate!
      FakeFS::FileSystem.clear
    end

    def deactivate_fake_fs
      FakeFS.deactivate!
    end

  end
end
require 'mocha'