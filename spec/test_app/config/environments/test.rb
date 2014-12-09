TestApp::Application.configure do
  config.cache_classes                              = true
  config.eager_load                                 = false
  config.static_cache_control                       = 'public, max-age=3600'
  config.consider_all_requests_local                = true
  config.active_support.deprecation                 = :stderr
end
