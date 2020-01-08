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

require "haml"
require "gettext/tools/parser/ruby"

module GetTextHaml
  class Parser
    @config = {
      :extnames => [".haml"]
    }

    class << self
      # Sets some preferences to parse Haml files.
      # * config: a Hash of the config. It can takes some values below:
      #   * :extnames: An Array of target files extension. Default is [".haml"].
      def init(config)
        config.each do |key, value|
          @config[key] = value
        end
      end

      def target?(file) # :nodoc:
        @config[:extnames].each do |extname|
          return true if File.extname(file) == extname
        end
        false
      end

      # Parses Haml file located at `path`.
      #
      # This is a short cut method. It equals to `new(path,
      # options).parse`.
      #
      # @return [Array<POEntry>] Extracted messages
      # @see #initialize and #parse
      def parse(path, options={})
        parser = new(path, options)
        parser.parse
      end
    end

    # @param path [String] Haml file path to be parsed
    # @param options [Hash]
    def initialize(path, options={})
      @path = path
      @options = options
    end

    # Extracts messages from @path.
    #
    # @return [Array<POEntry>] Extracted messages
    def parse
      content = IO.read(@path)
      source = Haml::Engine.new(content).precompiled

      encoding = detect_encoding(source) || content.encoding
      source.force_encoding(encoding)

      ruby_parser = GetText::RubyParser.new(@path, @options)
      ruby_parser.parse_source(source)
    end

    private
    def detect_encoding(erb_source)
      if /\A#coding:(.*)\n/ =~ erb_source
        $1
      else
        nil
      end
    end
  end
end
