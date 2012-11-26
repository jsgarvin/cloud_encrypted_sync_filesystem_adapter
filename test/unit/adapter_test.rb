require 'test_helper'

module CloudEncryptedSyncFilesystemAdapter
  class AdapterTest < ActiveSupport::TestCase

    def setup
      stub_configuration
    end

    def teardown
      unstub_configuration
    end

    # This is just a basic example (that will fail until you update it).
    test 'should parse command line options' do
      unstub_configuration
      Object.send(:remove_const,:ARGV)
      ::ARGV = '--destination-path /some/path'.split(/\s/)
      @option_parser = OptionParser.new do |parser|
        adapter.parse_command_line_options(parser)
      end
      @option_parser.parse!
      assert_equal('/some/path',CloudEncryptedSync::Adapters::Filesystem.instance.send(:destination_path))
      stub_configuration #just so that teardown unstub doesn't throw errors
    end

    test 'should write readable data to cloud and then delete it' do

      test_data = 'testdata'
      test_key = 'testkey'

      assert !adapter.key_exists?(test_key)

      assert_difference('adapter.instance.number_of_files_in_destination') do
        adapter.write(test_data,test_key)
      end
      assert adapter.key_exists?(test_key)

      assert_equal(test_data,adapter.read(test_key))

      assert_difference('adapter.instance.number_of_files_in_destination',-1) do
        adapter.delete(test_key)
      end
      assert !adapter.key_exists?(test_key)

    end

    # Your adapter should be written in such a way that this test passes as is.
    test 'should raise NoSuchKey error' do
      assert_raises(CloudEncryptedSync::Errors::NoSuchKey) { adapter.read('nonexistentkey') }
    end

    #######
    private
    #######

    def adapter
      CloudEncryptedSync::Adapters::Filesystem
    end

    # Setup test configuration values here as if they were passed in as command line arguments
    def stub_configuration
      CloudEncryptedSync::Adapters::Filesystem.any_instance.stubs(:destination_path).returns('/some/path')
    end

    # Remove stubbed settings here that were stubbed in above method.
    def unstub_configuration
      CloudEncryptedSync::Adapters::Filesystem.any_instance.unstub(:destination_path)
    end
  end
end