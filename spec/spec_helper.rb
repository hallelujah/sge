$LOAD_PATH.unshift('lib')

require 'sge'
RSpec.configure do |config|
  config.mock_with :rspec
end
