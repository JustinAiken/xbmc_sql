begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'XbmcSql'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include 'README.markdown'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
end

desc "Run tests for CI"
task :default do
  Rake::Task["db:bootstrap"].invoke
  Rake::Task["spec"].invoke
end

namespace :db do
  desc "Wipe development/test db's and replace with seed copy"
  task :bootstrap do
    DB_PATH  = "spec/test_app/db/"
    TEMPLATE = "fresh_db.sqlite3"
    DEV_DB   = "development.db"
    TEST_DB  = "test.db"

    system *%W[rm -f #{DB_PATH}#{DEV_DB}]
    system *%W[rm -f #{DB_PATH}#{TEST_DB}]
    system *%W[cp #{DB_PATH}#{TEMPLATE} #{DB_PATH}#{DEV_DB}]
    system *%W[cp #{DB_PATH}#{TEMPLATE} #{DB_PATH}#{TEST_DB}]
  end
end

APP_RAKEFILE = File.expand_path("../spec/test_app/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

unless defined?(Thor) && defined?(Thor::Base)
  require 'thor'
end

Bundler::GemHelper.install_tasks
