module XbmcSql

  DATABASE = "xbmc_#{Rails.env}".to_sym

  class Engine < ::Rails::Engine
    isolate_namespace XbmcSql

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
