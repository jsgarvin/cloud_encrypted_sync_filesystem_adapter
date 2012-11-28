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
        File.open(storage_path_to(key),'w') { |file| file.write(data) }
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

      def key_exists?(key)
        File.exist?(storage_path_to(key))
      end

      #######
      private
      #######

      def storage_path_to(key)
        "#{expanded_and_created_storage_path}/#{key}"
      end

      def expanded_and_created_storage_path
        FileUtils.mkdir_p(expanded_storage_path)
        return expanded_storage_path
      end

      def expanded_storage_path
        File.expand_path(storage_path)
      end

    end
  end
end