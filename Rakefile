require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the devise_pam_authenticatable plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the devise_pam_authenticatable plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DevisePAMAuthenticatable'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "devise_pam_authenticatable"
    gemspec.summary = "Devise PAM authentication module using rpam"
    gemspec.description = "For authenticating against PAM (Pluggable Authentication Modules)"
    gemspec.email = "jwilson@lithiumcorp.com"
    gemspec.homepage = "http://github.com/jwilson511/devise_pam_authenticatable"
    gemspec.authors = ["James Wilson"]
    gemspec.add_runtime_dependency "devise", "> 1.1.0"
    gemspec.add_runtime_dependency "rpam"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
