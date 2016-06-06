require 'spec_helper'
require 'kayvee/clients/test'

module Kayvee
  describe Key do
    before do
      @options = {}
      @client = Clients::Test.new(@options)
      @path = double
      @value = double
    end

    describe 'initialize' do
      it 'sets a client and path' do
        key = Key.new(@client, @path)

        expect(key.path).to eq(@path)
        expect(key.instance_variable_get(:@client)).to eq(@client)
        expect(key.instance_variable_get(:@value)).to eq(nil)
      end

      it 'can set a value' do
        key = Key.new(@client, @path, @value)

        expect(key.path).to eq(@path)
        expect(key.instance_variable_get(:@client)).to eq(@client)
        expect(key.instance_variable_get(:@value)).to eq(@value)
      end
    end

    describe 'read' do
      it 'returns the value if set' do
        key = Key.new(@client, @path, @value)

        expect(key.read).to eq(@value)
      end

      it 'returns nil if the value is not set' do
        key = Key.new(@client, @path)

        expect(key.read).to eq(nil)
      end

      it 'returns the written value' do
        key = Key.new(@client, @path)
        key.write(@value)

        expect(key.read).to eq(@value)
      end
    end

    describe 'write' do
      it 'sets the key value' do
        key = Key.new(@client, @path)
        key.write(@value)

        expect(key.read).to eq(@value)
      end

      it 'writes the value via the client' do
        key = Key.new(@client, @path)
        key.write(@value)

        expect(key.read).to eq(@value)
      end

      it 'returns the key' do
        key = Key.new(@client, @path)
        ret = key.write(@value)

        expect(ret).to be_a(Kayvee::Key)
      end
    end
  end
end
