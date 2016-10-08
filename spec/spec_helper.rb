$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['ENV'] = 'test'

require 'kayvee'
require 'dotenv'
require 'fakeredis'

Dotenv.load('.env.test')

