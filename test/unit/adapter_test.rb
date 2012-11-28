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
      ::ARGV = '--storage-path /some/path'.split(/\s/)
      @option_parser = OptionParser.new do |parser|
        adapter.parse_command_line_options(parser)
      end
      @option_parser.parse!
      assert_equal('/some/path',CloudEncryptedSync::Adapters::Filesystem.instance.send(:storage_path))
      stub_configuration #just so that teardown unstub doesn't throw errors
    end

    test 'should write readable data to cloud and then delete it' do

      test_data = 'testdata'
      test_key = 'testkey'

      assert !adapter.key_exists?(test_key)

      assert_difference('number_of_files_in_storage') do
        adapter.write(test_data,test_key)
      end
      assert adapter.key_exists?(test_key)

      assert_equal(test_data,adapter.read(test_key))

      assert_difference('number_of_files_in_storage',-1) do
        adapter.delete(test_key)
      end
      assert !adapter.key_exists?(test_key)

    end

    # Your adapter should be written in such a way that this test passes as is.
    test 'should raise NoSuchKey error' do
      assert_raises(CloudEncryptedSync::Errors::NoSuchKey) { adapter.read('nonexistentkey') }
    end

    test 'should return false for non existent keys' do
      refute adapter.key_exists?('nonexistentkey')
    end

    test 'should return true to existent keys' do
      key = 'foobar'
      File.open(storage_path_to(key),'w') { |file| file.write('Hello, World!') }
      assert adapter.key_exists?(key)
    end

    test 'should write to storage' do
      key = 'foobar'
      refute adapter.key_exists?(key)
      assert_difference('number_of_files_in_storage') do
        adapter.write('this is my handle, this is my spout',key)
      end
      assert adapter.key_exists?(key)
    end

    test 'should read file from storage' do
      key = 'foobar'
      data = 'Hello, World!'
      File.open(storage_path_to(key),'w') { |file| file.write(data) }
      assert_equal(data,adapter.read(key))
    end

    test 'should delete file from storage' do
      key = 'foobar'
      data = 'Hello, World!'
      File.open(storage_path_to(key),'w') { |file| file.write(data) }
      assert_difference('number_of_files_in_storage',-1) do
        adapter.delete(key)
      end
    end

    #######
    private
    #######

    def number_of_files_in_storage
      Dir["#{full_storage_path}/*"].length
    end

    def storage_path_to(key)
      adapter.send(:storage_path_to,key)
    end

    def full_storage_path
      adapter.send(:expanded_storage_path)
    end

    def adapter
      CloudEncryptedSync::Adapters::Filesystem.instance
    end

    # Setup test configuration values here as if they were passed in as command line arguments
    def stub_configuration
      CloudEncryptedSync::Adapters::Filesystem.any_instance.stubs(:storage_path).returns(File.expand_path('../test_storage_folder',  __FILE__))
    end

    # Remove stubbed settings here that were stubbed in above method.
    def unstub_configuration
      CloudEncryptedSync::Adapters::Filesystem.any_instance.unstub(:storage_path)
    end
  end
end