module CloudEncryptedSync
  module Adapters
    class Filesystem < Template
      attr_accessor :storage_path

      def parse_command_line_options(parser)
        parser.on('--storage-path PATH', 'Path to folder where encrypted files are/will be stored.') do |storage|
          self.storage_path = storage
        end
      end

      # CES will call this method when there is data to write.
      #
      # It should accept data to write and a key that will be used to
      # retreive the data later.
      def write(data, key)
        raise Errors::TemplateMethodCalled.new('write')
      end

      # CES will call this method to fetch data.
      #
      # It should accept a key as an argument and return the data
      # associated with that key on a previous write.
      # It should raise an Errors::NoSuchKey exception if the
      # key does not exist.
      def read(key)
        raise Errors::TemplateMethodCalled.new('read')
      end

      # CES will call this method to delete the data.
      #
      # It should accept a key as an argument and delete the
      # data associated with that key on a previous write.
      def delete(key)
        raise Errors::TemplateMethodCalled.new('delete')
      end

      # CES will call this method to check for the existance
      # of a key.
      #
      # It should accept a key as an argument and return a
      # boolean.
      def key_exists?(key)
        raise Errors::TemplateMethodCalled.new('key_exists?')
      end

    end
  end
end