require 'spec_helper'
require 'securerandom'

module Kayvee
  [:redis, :s3, :memory].each do |impl|
    describe "a working #{impl} implementation" do
      before do
        @opts = {}

        case impl
        when :s3
          @opts.merge!({
            aws_access_key: ENV['AWS_ACCESS_KEY'],
            aws_secret_key: ENV['AWS_SECRET_KEY'],
            bucket_name: ENV['AWS_BUCKET'],
          })
        end
      end

      it 'can get and set keys' do
        key = SecureRandom.uuid
        value = 'test'

        store = Store.new(impl, @opts)
        store.set(key, value)

        expect(store.get(key).read).to eq(value)
      end

      it 'can handle non existant keys' do
        key = SecureRandom.uuid
        store = Store.new(impl, @opts)

        expect(store.get(key).read).to eq(nil)
      end
    end
  end
end
