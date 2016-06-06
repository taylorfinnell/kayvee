require 'spec_helper'
require 'kayvee/clients/s3'

module Kayvee
  module Clients
    describe S3 do
      before do
        @s3 = S3.new({
          aws_access_key: ENV['AWS_ACCESS_KEY'],
          aws_secret_key: ENV['AWS_SECRET_KEY'],
          bucket_name: ENV['AWS_BUCKET'],
          prefix: ENV['AWS_PREFIX']
        })
      end

      describe '#write' do
        it 'can write a string' do
          @s3.write('test', 'sup')

          expect(@s3.read('test')).to eq('sup')
        end

        it 'can write an io' do
          @s3.write('test', StringIO.new('sup'))

          expect(@s3.read('test')).to eq('sup')
        end
      end
    end
  end
end
