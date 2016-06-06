require 'spec_helper'

module Kayvee
  describe Store do
    describe 'initialize' do
      it 'creates a client from a symbol' do
        store = Store.new(:test)

        expect(store.client).to be_a(Kayvee::Clients::Test)
      end

      it 'passes options to the client' do
        options = double
        expect(Kayvee::Clients::Test).to receive(:new).with(options)

        Store.new(:test, options)
      end
    end

    describe 'get' do
      it 'returns a key object with for the given path' do
        store = Kayvee::Store.new(:test)
        key = store.get('test')

        expect(key).to be_a(Kayvee::Key)
      end
    end

    describe 'set' do
      it 'sets a key\'s value and returns the key' do
        path, value = 'test', 'test'

        expect_any_instance_of(Kayvee::Key).to receive(:write).with(value)

        store = Kayvee::Store.new(:test)
        key = store.set(path, value)

        expect(key).to be_a(Kayvee::Key)
        expect(key.path).to eq(path)
      end
    end
  end
end
