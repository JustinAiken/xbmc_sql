guard :rspec, all_after_pass: false, all_on_start: false, failed_mode: :none, cmd: 'SIMPLECOV=false rspec --color --no-profile --format progress' do

  # Run all tests if these change:
  watch('spec/spec_helper.rb')               { 'spec' }
  watch(%r{^spec/support/(.+)\.rb$})         { 'spec' }

  # Any spec runs itself:
  watch(%r{^spec/.+_spec\.rb$})

  # app/foo runs spec/foo, lib/foo runs spec/lib/foo...
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end
