ENV['RAILS_ENV'] ||= 'test'

require 'factory_girl_rails'
require File.expand_path("../../spec/test_app/config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'

require 'coveralls'
Coveralls.wear!

Dir[Rails.root.join("../../spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("../../spec/factories/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.use_transactional_fixtures                 = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order                                      = 'random'
end
