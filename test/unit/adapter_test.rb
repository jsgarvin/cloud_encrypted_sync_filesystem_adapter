require 'test_helper'

module CloudEncryptedSyncBaselineAdapter
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
      ::ARGV = '--foo bar'.split(/\s/)
      @option_parser = OptionParser.new do |parser|
        adapter.parse_command_line_options(parser)
      end
      @option_parser.parse!
      assert_equal('bar',CloudEncryptedSync::Adapters::Baseline.instance.send(:foo))
      stub_configuration #just so that teardown unstub doesn't throw errors
    end

    # Suggestion:
    # Replace number_of_files_in_destination with your own method that
    # returns an integer representiong the total number of files that
    # should be stored in the target cloud.  Otherwise, re-write this
    # entire test as you see fit to best evaluate your adapter code.
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
      CloudEncryptedSync::Adapters::Baseline
    end

    # Setup test configuration values here as if they were passed in as command line arguments
    def stub_configuration
      CloudEncryptedSync::Adapters::Baseline.any_instance.stubs(:foo).returns('bar')
    end

    # Remove stubbed settings here that were stubbed in above method.
    def unstub_configuration
      CloudEncryptedSync::Adapters::Baseline.any_instance.unstub(:foobar)
    end
  end
end