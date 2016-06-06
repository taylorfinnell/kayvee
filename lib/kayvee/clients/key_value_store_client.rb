module Kayvee
  module Clients
    # Represents the interfaces required to have a proper client for the
    # Kayvee::Store
    #
    # @see Kayvee::Store
    # @see Kayvee::Clients
    module KeyValueStoreClient
      # Raised when a client has not implemented a required method
      InterfaceNotImplementedError = Class.new(NotImplementedError)

      # Raised in validate_config! if invalid config is found
      OptionMissingError = Class.new(NotImplementedError)

      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        attr_reader :options

        # @param [String] path the path to convert to a url
        #
        # @return [String] the url
        def url(path)
          raise InterfaceNotImplementedError.new
        end

        # @param [String] path the path to read
        #
        # @return [String\nil] the read string or nil if key does not exist
        def read(path)
          raise InterfaceNotImplementedError.new
        end

        # @param [String] path the path to read
        # @param [String] value the value to set
        #
        # @return [Key] the key modified
        def write(path, value)
          raise InterfaceNotImplementedError.new
        end

        def write_io(path, io)
          raise InterfaceNotImplementedError.new
        end

        private

        def validate_options!
          raise InterfaceNotImplementedError.new
        end
      end
    end
  end
end
