require 'rubygems'
require 'rake/clean'
require 'rake/gempackagetask'
 
spec = Gem::Specification.new do |s|
  s.name = %q{collabrowser}
  s.version = "0.1.2"
  s.date = %q{2006-07-11}
  s.summary = %q{Collabrowser - see what others see on the Web}
  s.email = %q{ernest.micklei@gmail.com}
  s.homepage = %q{http://www.philemonworks.com/collabrowse}
  s.description = %q{Requires Windows platform (sorry) because of IE dependency}
  s.autorequire = %q{}
  s.has_rdoc = true
  s.authors = ["Ermest Micklei"]
  # bin
  s.files += Dir.new('./bin').entries.select{|e| e =~ /^[^.]/}.collect{|e| 'bin/'+e}
  # lib
  s.files += Dir.new('./lib').entries.select{|e| e =~ /\.rb$/}.collect{|e| 'lib/'+e}
  # samples
  s.files += Dir.new('./samples').entries.select{|e| e =~ /^[^.]/}.collect{|e| 'samples/'+e}
  s.test_files = Dir.new('./tests').entries.select{|e| e =~ /^[^.].*\.rb$/}.collect{|e| 'tests/'+e}
  s.rdoc_options = ["--title", "Collabrowser", "--main", "README", "--line-numbers"]
  s.extra_rdoc_files = ['README']
  s.executables = ['collabrowser','collaserver']  
  s.default_executable = %q{collabrowser}  
#s.add_dependency('builder', '>= 1.2.4')
end

Rake::GemPackageTask.new(spec) do |pkg| end

task :install do
    Gem::GemRunner.new.run(['install','pkg/collabrowser'])
end

desc "Default Task"
task :default => [ :package ,:install ]
   
