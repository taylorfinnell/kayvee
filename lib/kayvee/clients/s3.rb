begin
  require 's3'
rescue LoadError => e
  raise "You must include the s3 gem in your Gemfile"
end

module Kayvee
  module Clients
    # An s3 backed kv store
    class S3
      include KeyValueStoreClient

      InvalidBucketError = Class.new(StandardError)

      def initialize(options)
        @options = options
        validate_options!

        @s3 = ::S3::Service.new(access_key_id: aws_access_key,
                                  secret_access_key: aws_secret_key)
      end

      # Gets an s3 url for the key
      #
      # @param [String] path the path to read
      #
      # @return [String] the url
      def url(path)
        get(path).temporary_url
      end

      # @param [String] path the path to read
      #
      # @return [String\nil] the read string or nil if key does not exist
      def read(path)
        begin
          value = nil
          obj =  get(path)
          value = obj.content if obj
          value
        rescue ::S3::Error::NoSuchKey => e
          nil
        end
      end

      # @param [String/IO] path the path to read
      # @param [String] value the value to set
      #
      # @return [Key] the modified key
      def write(path, value)
        obj = build(path)
        obj.content = value
        obj.save
      end

      # Check if key exists in the store
      #
      # @param [String] path the key path
      # @return [Bool] true of false
      def exists?(path)
        get(path).exists?
      end

      # Clear the store
      #
      # @return [Bool] true if all items removed, else false
      def clear
        objects.map(&:destroy).reduce(&:&)
      end

      # Get the size of the store
      #
      # @return [Integer] size of store
      def size
        objects.count
      end

      private

      def build(path)
        objects.build(path)
      end

      def get(path)
        objects.find(path)
      end

      def objects
        bucket.objects
      end

      def bucket
        if bucket = @s3.buckets.find(bucket_name)
          bucket
        else
          raise InvalidBucketError, "bucket #{bucket_name} is invalid"
        end
      end

      def validate_options!
        raise OptionMissingError.new, 'missing aws key' unless aws_access_key
        raise OptionMissingError.new, 'missing aws secret' unless aws_secret_key
        raise OptionMissingError.new, 'missing bucket name' unless bucket_name
      end

      def bucket_name
        options[:bucket_name]
      end

      def aws_access_key
        options[:aws_access_key]
      end

      def aws_secret_key
        options[:aws_secret_key]
      end
    end
  end
end
