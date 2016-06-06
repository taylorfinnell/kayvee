module Kayvee
  module Clients
    # An in memory kv store
    class Memory
      include KeyValueStoreClient

      # @param [Hash] options for the client
      def initialize(options)
        @options = options
        validate_options!
        @store = {}
      end

      # @param [String] path the path to read
      #
      # @return [String\nil] the read string or nil if key does not exist
      def read(path)
        @store[path]
      end

      # @param [String] path the path to read
      # @param [String] value the value to set
      #
      # @return [Key] the modified key
      def write(path, value)
        @store[path] = value
      end

      private

      def validate_options!
        true
      end
    end
  end
end
