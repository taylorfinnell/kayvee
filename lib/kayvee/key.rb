module Kayvee
  # Represents a key that can hold a value.
  class Key
    # The path of the key
    # @todo this should be named key, probably
    attr_reader :path

    # @param [Kayvee::Clients::KeyValueStoreClient] client the client to use to back the key
    # @param [String] path the path of the key
    # @param [String] value the value of the key
    def initialize(client, path, value = nil)
      @client = client
      @path = path
      @value = value
      @mutex = Mutex.new
    end

    def exists?
      begin
        @client.exists?(@path)
      rescue ::S3::Error::NoSuchKey => e
        nil
      end
    end

    # Returns a public url for the given path
    def url
      @mutex.synchronize { @client.url(@path) }
    end

    # Reads the value of the key, if the value is been read it returns it. If the value
    # has not yet been read it reaches out to the client
    #
    # @return [String\nil] the value of the key or nil if key does not exist
    def read
      @mutex.synchronize do
        @value ||= @client.read(@path)
        @value
      end
    end

    # Writes a contents string to the key
    #
    # @param [String] contents the contents to set in the key
    #
    # @return the modified or created key
    def write(contents)
      @mutex.synchronize do
        @value = contents
        @client.write(@path, @value)
        self
      end
    end
  end
end
