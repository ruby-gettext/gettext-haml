# -*- ruby -*-
#
# Copyright (C) 2020  Sutou Kouhei <kou@clear-code.com>
#
# This library is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this library.  If not, see <http://www.gnu.org/licenses/>.

require "bundler/gem_helper"
require "yard"

class Bundler::GemHelper
  undef_method :version_tag
  def version_tag
    version
  end
end

helper = Bundler::GemHelper.new(__dir__)
helper.install
spec = helper.gemspec

task :default => :test

desc "Run all tests"
task :test do
  options = ARGV - Rake.application.top_level_tasks
  ruby "test/run-test.rb", *options
end

YARD::Rake::YardocTask.new do |t|
end
