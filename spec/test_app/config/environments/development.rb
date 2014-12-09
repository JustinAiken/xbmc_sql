TestApp::Application.configure do
  config.cache_classes                       = false
  config.eager_load                          = false
  config.active_support.deprecation          = :log
  config.active_record.migration_error       = :page_load
  config.assets.debug                        = true
  config.assets.raise_runtime_errors         = true
end
