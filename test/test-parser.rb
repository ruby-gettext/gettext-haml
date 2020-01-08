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

class ParserTest < Test::Unit::TestCase
  def setup
    @haml_file = Tempfile.new(["test", ".haml"])
  end

  def parse(content)
    @haml_file.rewind
    @haml_file.print(content)
    @haml_file.rewind
    GetTextHaml::Parser.parse(@haml_file.path)
  end

  def assert_parse(expected, content)
    assert_equal(normalize_expected(expected),
                 normalize_actual(parse(content)))
  end

  def normalize_expected(messages)
    messages.collect do |message|
      default = {
        :msgid        => nil,
        :msgid_plural => nil,
        :msgstr       => nil,
        :separator    => nil,
        :references   => nil,
      }
      default.merge(message)
    end
  end

  def normalize_actual(po)
    po.collect do |po_entry|
      {
        :msgid        => po_entry.msgid,
        :msgid_plural => po_entry.msgid_plural,
        :msgstr       => po_entry.msgstr,
        :separator    => po_entry.separator,
        :references   => po_entry.references,
      }
    end
  end

  def test_encoding_magic_comment
    assert_parse([
                   {
                     :msgid => "こんにちは".encode("cp932"),
                     :references => ["#{@haml_file.path}:3"],
                   }
                 ],
                 <<-HAML.encode("cp932"))
-# -*- coding: cp932 -*-
%p
  = _("こんにちは")
                 HAML
  end

  def test_no_paren
    assert_parse([
                   {
                     :msgid => "Hello",
                     :references => ["#{@haml_file.path}:2"],
                   }
                 ],
                 <<-HAML.encode("cp932"))
%p
  = _ "Hello"
                 HAML
  end
end
