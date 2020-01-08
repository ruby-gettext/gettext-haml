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

require_relative "lib/gettext-haml/version"

Gem::Specification.new do |s|
  s.name = "gettext-haml"
  s.version = GetTextHaml::VERSION
  s.summary = "This is a gettext plugin to support Haml."
  s.description = <<-DESCRIPTION
You can extract messages from Haml files with this library.
  DESCRIPTION
  s.authors = ["Kouhei Sutou"]
  s.email = ["kou@clear-code.com"]
  s.homepage = "https://ruby-gettext.github.io/"
  s.license = "LGPLv3+"

  s.require_paths = ["lib"]
  s.files = Dir.glob("lib/**/*.rb")
  s.files += Dir.glob("doc/text/**/*.*")
  s.files += [
    "#{s.name}.gemspec",
    ".yardopts",
    "Gemfile",
    "README.md",
    "Rakefile",
  ]
  s.test_files = Dir.glob("test/**/*.rb")

  s.add_runtime_dependency("gettext")
  s.add_runtime_dependency("haml")
  s.add_development_dependency("kramdown")
  s.add_development_dependency("rake")
  s.add_development_dependency("test-unit")
  s.add_development_dependency("yard")
end
