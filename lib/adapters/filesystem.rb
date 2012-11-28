module CloudEncryptedSync
  module Adapters
    class Filesystem < Template
      attr_accessor :storage_path

      def parse_command_line_options(parser)
        parser.on('--storage-path PATH', 'Path to folder where encrypted files are/will be stored.') do |storage|
          self.storage_path = storage
        end
      end

      def write(data, key)
        File.open(storage_path_to(key),'w') { |file| file.write(data) }
      end

      def read(key)
        if key_exists?(key)
          File.read(storage_path_to(key))
        else
          raise Errors::NoSuchKey.new(key)
        end
      end

      def delete(key)
        if key_exists?(key)
          File.delete(storage_path_to(key))
        else
          raise Errors::NoSuchKey.new(key)
        end
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