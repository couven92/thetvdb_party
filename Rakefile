require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rspec/core/rake_task'

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib/**/*.rb")
  rdoc.rdoc_dir = "doc"
  rdoc.options << "--line-numbers"
end

RSpec::Core::RakeTask.new do |rspec|
end

namespace :spec do
  RSpec::Core::RakeTask.new :html do |rspec|
    rspec.name = "spec::html"
    rspec.rspec_opts = %w(--format html --out .report/rspec_test_report.html)
  end
end
