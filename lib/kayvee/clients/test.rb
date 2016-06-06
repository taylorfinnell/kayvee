require 'kayvee/clients/memory'

module Kayvee
  module Clients
    # An memory backed kv store for use in tests.
    class Test < Memory
    end
  end
end
