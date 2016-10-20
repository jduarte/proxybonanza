$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'proxybonanza'
require './lib/proxybonanza'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr_cassetes"
  c.hook_into :webmock
end
