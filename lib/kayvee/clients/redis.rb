begin
  require 'redis'
rescue LoadError => e
  raise "You must include the 'redis' gem in your Gemfile"
end

module Kayvee
  module Clients
    # An redis backed kv store
    class Redis
      include KeyValueStoreClient

      # @param [Hash] options for the client
      def initialize(options)
        @options = options
        validate_options!

        @store = ::Redis.new(url: 'redis://localhost')
      end

      # @param [String] path the path to read
      #
      # @return [String\nil] the read string or nil if key does not exist
      def read(path)
        @store.get(path)
      end

      # @param [String] path the path to read
      # @param [String] value the value to set
      #
      # @return [Key] the modified key
      def write(path, value)
        @store.set(path, value)
      end

      private

      def validate_options!
        true
      end
    end
  end
end
