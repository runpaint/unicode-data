require 'rubygems'
require 'rake'
$LOAD_PATH.unshift('lib')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "unicode-data"
    gem.summary = %Q{Ruby interface to UnicodeData.txt}
    gem.description = %Q{Low-level interface to UnicodeData.txt}
    gem.email = "runrun@runpaint.org"
    gem.homepage = "http://github.com/runpaint/unicode-data"
    gem.authors = ["Run Paint Run Run"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "yard"
    gem.files.include 'data/*index'


    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec


task :build_index do
  require 'unicode-data'
  UnicodeData.build_index
end

Rake::Task["gemspec"].prerequisites << "build_index" if Rake::Task.task_defined?("gemspec")

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
