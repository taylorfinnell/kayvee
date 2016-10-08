module Kayvee
  # Represents a simple key value store. Provides multiple backing stores.
  #
  # @example Basic Useage
  #   store = Kayvee::Store.new(:s3, aws_access_key: '', ... )
  #   key = store.set('hello', 'world')
  #   key.read
  #     => 'world'
  #
  #   store = Kayvee::Store.new(:redis, host: 'redis://locahost')
  #   key = store.set('hello', 'world')
  #   key.read
  #     => 'world'
  #
  # @see Kayvee::Clients::S3
  # @see Kayvee::Clients::Redis
  # @see Kayvee::Clients::Memory
  # @see Kayvee::Clients::Test
  class Store
    # Raised when a client implementation can not be found.
    ClientNotFound = Class.new(Exception)

    # The internal client driving the store
    attr_reader :client

    # @param [Symbol] client the symbol representing the client to use. :s3, :redis, :memory, :test
    # @param [Options] options the config for the client implementation
    #
    # @see Kayvee::Clients::S3
    # @see Kayvee::Clients::Redis
    # @see Kayvee::Clients::Memory
    # @see Kayvee::Clients::Test
    def initialize(client = :s3, options = {})
      load_client(client)
      @client = instantiate_client(client, options)
    end

    # Sets a given key to a given value
    #
    # @param [String] path the path to set
    # @param [String] value the value to set
    #
    # @return [Key] the newly created or modified key object
    def set(path, value)
      key = Kayvee::Key.new(@client, path)
      key.write(value)
      key
    end
    alias :[]= :set

    # Gets a given keys value
    #
    # @param [String] path the path to set
    #
    # @return [Key] the value of the key
    def get(path)
      Kayvee::Key.new(@client, path)
    end
    alias :[] :get

    # Clear the underlying store
    def clear
      @client.clear
    end

    def size
      @client.size
    end

    private

    def instantiate_client(client, options)
      begin
        klass = "Kayvee::Clients::#{client.capitalize}".constantize
        klass.new(options)
      rescue NameError
        raise ClientNotFound.new
      end
    end

    def load_client(client)
      begin
        require "kayvee/clients/#{client}"
      rescue LoadError => load_error
        raise LoadError.new("Cannot find Kayvee::Clients::#{client.capitalize} adapter '#{client}' (#{load_error.message})")
      end
    end
  end
end
