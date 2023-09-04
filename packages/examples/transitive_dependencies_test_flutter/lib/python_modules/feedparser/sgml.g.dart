// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library sgml;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## EndBracketMatch
///
/// ### python source
/// ```py
/// class EndBracketMatch:
///     def __init__(self, match):
///         self.match = match
///
///     def start(self, n):
///         return self.match.end(n)
/// ```
final class EndBracketMatch extends PythonClass {
  factory EndBracketMatch({
    required Object? match,
  }) =>
      PythonFfiDart.instance.importClass(
        "feedparser.sgml",
        "EndBracketMatch",
        EndBracketMatch.from,
        <Object?>[
          match,
        ],
        <String, Object?>{},
      );

  EndBracketMatch.from(super.pythonClass) : super.from();

  /// ## start
  ///
  /// ### python source
  /// ```py
  /// def start(self, n):
  ///         return self.match.end(n)
  /// ```
  Object? start({
    required Object? n,
  }) =>
      getFunction("start").call(
        <Object?>[
          n,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## match (getter)
  Object? get match => getAttribute("match");

  /// ## match (setter)
  set match(Object? match) => setAttribute("match", match);
}

/// ## SGMLParseError
///
/// ### python docstring
///
/// Exception raised for all parse errors.
///
/// ### python source
/// ```py
/// class SGMLParseError(RuntimeError):
///     """Exception raised for all parse errors."""
///     pass
/// ```
final class SGMLParseError extends PythonClass {
  factory SGMLParseError() => PythonFfiDart.instance.importClass(
        "sgmllib",
        "SGMLParseError",
        SGMLParseError.from,
        <Object?>[],
      );

  SGMLParseError.from(super.pythonClass) : super.from();

  /// ## args (getter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  Object? get args => getAttribute("args");

  /// ## args (setter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  ///
  /// ### python docstring
  ///
  /// Exception raised for all parse errors.
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## SGMLParser
///
/// ### python docstring
///
/// Parser base class which provides some common support methods used
/// by the SGML/HTML and XHTML parsers.
///
/// ### python source
/// ```py
/// class SGMLParser(_markupbase.ParserBase):
///     # Definition of entities -- derived classes may override
///     entity_or_charref = re.compile('&(?:'
///       '([a-zA-Z][-.a-zA-Z0-9]*)|#([0-9]+)'
///       ')(;?)')
///
///     def __init__(self, verbose=0):
///         """Initialize and reset this instance."""
///         self.verbose = verbose
///         self.reset()
///
///     def reset(self):
///         """Reset this instance. Loses all unprocessed data."""
///         self.__starttag_text = None
///         self.rawdata = ''
///         self.stack = []
///         self.lasttag = '???'
///         self.nomoretags = 0
///         self.literal = 0
///         _markupbase.ParserBase.reset(self)
///
///     def setnomoretags(self):
///         """Enter literal mode (CDATA) till EOF.
///
///         Intended for derived classes only.
///         """
///         self.nomoretags = self.literal = 1
///
///     def setliteral(self, *args):
///         """Enter literal mode (CDATA).
///
///         Intended for derived classes only.
///         """
///         self.literal = 1
///
///     def feed(self, data):
///         """Feed some data to the parser.
///
///         Call this as often as you want, with as little or as much text
///         as you want (may include '\n').  (This just saves the text,
///         all the processing is done by goahead().)
///         """
///
///         self.rawdata = self.rawdata + data
///         self.goahead(0)
///
///     def close(self):
///         """Handle the remaining data."""
///         self.goahead(1)
///
///     def error(self, message):
///         raise SGMLParseError(message)
///
///     # Internal -- handle data as far as reasonable.  May leave state
///     # and data to be processed by a subsequent call.  If 'end' is
///     # true, force handling all data as if followed by EOF marker.
///     def goahead(self, end):
///         rawdata = self.rawdata
///         i = 0
///         n = len(rawdata)
///         while i < n:
///             if self.nomoretags:
///                 self.handle_data(rawdata[i:n])
///                 i = n
///                 break
///             match = interesting.search(rawdata, i)
///             if match: j = match.start()
///             else: j = n
///             if i < j:
///                 self.handle_data(rawdata[i:j])
///             i = j
///             if i == n: break
///             if rawdata[i] == '<':
///                 if starttagopen.match(rawdata, i):
///                     if self.literal:
///                         self.handle_data(rawdata[i])
///                         i = i+1
///                         continue
///                     k = self.parse_starttag(i)
///                     if k < 0: break
///                     i = k
///                     continue
///                 if rawdata.startswith("</", i):
///                     k = self.parse_endtag(i)
///                     if k < 0: break
///                     i = k
///                     self.literal = 0
///                     continue
///                 if self.literal:
///                     if n > (i + 1):
///                         self.handle_data("<")
///                         i = i+1
///                     else:
///                         # incomplete
///                         break
///                     continue
///                 if rawdata.startswith("<!--", i):
///                         # Strictly speaking, a comment is --.*--
///                         # within a declaration tag <!...>.
///                         # This should be removed,
///                         # and comments handled only in parse_declaration.
///                     k = self.parse_comment(i)
///                     if k < 0: break
///                     i = k
///                     continue
///                 if rawdata.startswith("<?", i):
///                     k = self.parse_pi(i)
///                     if k < 0: break
///                     i = i+k
///                     continue
///                 if rawdata.startswith("<!", i):
///                     # This is some sort of declaration; in "HTML as
///                     # deployed," this should only be the document type
///                     # declaration ("<!DOCTYPE html...>").
///                     k = self.parse_declaration(i)
///                     if k < 0: break
///                     i = k
///                     continue
///             elif rawdata[i] == '&':
///                 if self.literal:
///                     self.handle_data(rawdata[i])
///                     i = i+1
///                     continue
///                 match = charref.match(rawdata, i)
///                 if match:
///                     name = match.group(1)
///                     self.handle_charref(name)
///                     i = match.end(0)
///                     if rawdata[i-1] != ';': i = i-1
///                     continue
///                 match = entityref.match(rawdata, i)
///                 if match:
///                     name = match.group(1)
///                     self.handle_entityref(name)
///                     i = match.end(0)
///                     if rawdata[i-1] != ';': i = i-1
///                     continue
///             else:
///                 self.error('neither < nor & ??')
///             # We get here only if incomplete matches but
///             # nothing else
///             match = incomplete.match(rawdata, i)
///             if not match:
///                 self.handle_data(rawdata[i])
///                 i = i+1
///                 continue
///             j = match.end(0)
///             if j == n:
///                 break # Really incomplete
///             self.handle_data(rawdata[i:j])
///             i = j
///         # end while
///         if end and i < n:
///             self.handle_data(rawdata[i:n])
///             i = n
///         self.rawdata = rawdata[i:]
///         # XXX if end: check for empty stack
///
///     # Extensions for the DOCTYPE scanner:
///     _decl_otherchars = '='
///
///     # Internal -- parse processing instr, return length or -1 if not terminated
///     def parse_pi(self, i):
///         rawdata = self.rawdata
///         if rawdata[i:i+2] != '<?':
///             self.error('unexpected call to parse_pi()')
///         match = piclose.search(rawdata, i+2)
///         if not match:
///             return -1
///         j = match.start(0)
///         self.handle_pi(rawdata[i+2: j])
///         j = match.end(0)
///         return j-i
///
///     def get_starttag_text(self):
///         return self.__starttag_text
///
///     # Internal -- handle starttag, return length or -1 if not terminated
///     def parse_starttag(self, i):
///         self.__starttag_text = None
///         start_pos = i
///         rawdata = self.rawdata
///         if shorttagopen.match(rawdata, i):
///             # SGML shorthand: <tag/data/ == <tag>data</tag>
///             # XXX Can data contain &... (entity or char refs)?
///             # XXX Can data contain < or > (tag characters)?
///             # XXX Can there be whitespace before the first /?
///             match = shorttag.match(rawdata, i)
///             if not match:
///                 return -1
///             tag, data = match.group(1, 2)
///             self.__starttag_text = '<%s/' % tag
///             tag = tag.lower()
///             k = match.end(0)
///             self.finish_shorttag(tag, data)
///             self.__starttag_text = rawdata[start_pos:match.end(1) + 1]
///             return k
///         # XXX The following should skip matching quotes (' or ")
///         # As a shortcut way to exit, this isn't so bad, but shouldn't
///         # be used to locate the actual end of the start tag since the
///         # < or > characters may be embedded in an attribute value.
///         match = endbracket.search(rawdata, i+1)
///         if not match:
///             return -1
///         j = match.start(0)
///         # Now parse the data between i+1 and j into a tag and attrs
///         attrs = []
///         if rawdata[i:i+2] == '<>':
///             # SGML shorthand: <> == <last open tag seen>
///             k = j
///             tag = self.lasttag
///         else:
///             match = tagfind.match(rawdata, i+1)
///             if not match:
///                 self.error('unexpected call to parse_starttag')
///             k = match.end(0)
///             tag = rawdata[i+1:k].lower()
///             self.lasttag = tag
///         while k < j:
///             match = attrfind.match(rawdata, k)
///             if not match: break
///             attrname, rest, attrvalue = match.group(1, 2, 3)
///             if not rest:
///                 attrvalue = attrname
///             else:
///                 if (attrvalue[:1] == "'" == attrvalue[-1:] or
///                     attrvalue[:1] == '"' == attrvalue[-1:]):
///                     # strip quotes
///                     attrvalue = attrvalue[1:-1]
///                 attrvalue = self.entity_or_charref.sub(
///                     self._convert_ref, attrvalue)
///             attrs.append((attrname.lower(), attrvalue))
///             k = match.end(0)
///         if rawdata[j] == '>':
///             j = j+1
///         self.__starttag_text = rawdata[start_pos:j]
///         self.finish_starttag(tag, attrs)
///         return j
///
///     # Internal -- convert entity or character reference
///     def _convert_ref(self, match):
///         if match.group(2):
///             return self.convert_charref(match.group(2)) or \
///                 '&#%s%s' % match.groups()[1:]
///         elif match.group(3):
///             return self.convert_entityref(match.group(1)) or \
///                 '&%s;' % match.group(1)
///         else:
///             return '&%s' % match.group(1)
///
///     # Internal -- parse endtag
///     def parse_endtag(self, i):
///         rawdata = self.rawdata
///         match = endbracket.search(rawdata, i+1)
///         if not match:
///             return -1
///         j = match.start(0)
///         tag = rawdata[i+2:j].strip().lower()
///         if rawdata[j] == '>':
///             j = j+1
///         self.finish_endtag(tag)
///         return j
///
///     # Internal -- finish parsing of <tag/data/ (same as <tag>data</tag>)
///     def finish_shorttag(self, tag, data):
///         self.finish_starttag(tag, [])
///         self.handle_data(data)
///         self.finish_endtag(tag)
///
///     # Internal -- finish processing of start tag
///     # Return -1 for unknown tag, 0 for open-only tag, 1 for balanced tag
///     def finish_starttag(self, tag, attrs):
///         try:
///             method = getattr(self, 'start_' + tag)
///         except AttributeError:
///             try:
///                 method = getattr(self, 'do_' + tag)
///             except AttributeError:
///                 self.unknown_starttag(tag, attrs)
///                 return -1
///             else:
///                 self.handle_starttag(tag, method, attrs)
///                 return 0
///         else:
///             self.stack.append(tag)
///             self.handle_starttag(tag, method, attrs)
///             return 1
///
///     # Internal -- finish processing of end tag
///     def finish_endtag(self, tag):
///         if not tag:
///             found = len(self.stack) - 1
///             if found < 0:
///                 self.unknown_endtag(tag)
///                 return
///         else:
///             if tag not in self.stack:
///                 try:
///                     method = getattr(self, 'end_' + tag)
///                 except AttributeError:
///                     self.unknown_endtag(tag)
///                 else:
///                     self.report_unbalanced(tag)
///                 return
///             found = len(self.stack)
///             for i in range(found):
///                 if self.stack[i] == tag: found = i
///         while len(self.stack) > found:
///             tag = self.stack[-1]
///             try:
///                 method = getattr(self, 'end_' + tag)
///             except AttributeError:
///                 method = None
///             if method:
///                 self.handle_endtag(tag, method)
///             else:
///                 self.unknown_endtag(tag)
///             del self.stack[-1]
///
///     # Overridable -- handle start tag
///     def handle_starttag(self, tag, method, attrs):
///         method(attrs)
///
///     # Overridable -- handle end tag
///     def handle_endtag(self, tag, method):
///         method()
///
///     # Example -- report an unbalanced </...> tag.
///     def report_unbalanced(self, tag):
///         if self.verbose:
///             print('*** Unbalanced </' + tag + '>')
///             print('*** Stack:', self.stack)
///
///     def convert_charref(self, name):
///         """Convert character reference, may be overridden."""
///         try:
///             n = int(name)
///         except ValueError:
///             return
///         if not 0 <= n <= 127:
///             return
///         return self.convert_codepoint(n)
///
///     def convert_codepoint(self, codepoint):
///         return chr(codepoint)
///
///     def handle_charref(self, name):
///         """Handle character reference, no need to override."""
///         replacement = self.convert_charref(name)
///         if replacement is None:
///             self.unknown_charref(name)
///         else:
///             self.handle_data(replacement)
///
///     # Definition of entities -- derived classes may override
///     entitydefs = \
///             {'lt': '<', 'gt': '>', 'amp': '&', 'quot': '"', 'apos': '\''}
///
///     def convert_entityref(self, name):
///         """Convert entity references.
///
///         As an alternative to overriding this method; one can tailor the
///         results by setting up the self.entitydefs mapping appropriately.
///         """
///         table = self.entitydefs
///         if name in table:
///             return table[name]
///         else:
///             return
///
///     def handle_entityref(self, name):
///         """Handle entity references, no need to override."""
///         replacement = self.convert_entityref(name)
///         if replacement is None:
///             self.unknown_entityref(name)
///         else:
///             self.handle_data(replacement)
///
///     # Example -- handle data, should be overridden
///     def handle_data(self, data):
///         pass
///
///     # Example -- handle comment, could be overridden
///     def handle_comment(self, data):
///         pass
///
///     # Example -- handle declaration, could be overridden
///     def handle_decl(self, decl):
///         pass
///
///     # Example -- handle processing instruction, could be overridden
///     def handle_pi(self, data):
///         pass
///
///     # To be overridden -- handlers for unknown objects
///     def unknown_starttag(self, tag, attrs): pass
///     def unknown_endtag(self, tag): pass
///     def unknown_charref(self, ref): pass
///     def unknown_entityref(self, ref): pass
/// ```
final class SGMLParser extends PythonClass {
  factory SGMLParser({
    Object? verbose = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "sgmllib",
        "SGMLParser",
        SGMLParser.from,
        <Object?>[
          verbose,
        ],
        <String, Object?>{},
      );

  SGMLParser.from(super.pythonClass) : super.from();

  /// ## close
  ///
  /// ### python docstring
  ///
  /// Handle the remaining data.
  ///
  /// ### python source
  /// ```py
  /// def close(self):
  ///         """Handle the remaining data."""
  ///         self.goahead(1)
  /// ```
  Object? close() => getFunction("close").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## convert_charref
  ///
  /// ### python docstring
  ///
  /// Convert character reference, may be overridden.
  ///
  /// ### python source
  /// ```py
  /// def convert_charref(self, name):
  ///         """Convert character reference, may be overridden."""
  ///         try:
  ///             n = int(name)
  ///         except ValueError:
  ///             return
  ///         if not 0 <= n <= 127:
  ///             return
  ///         return self.convert_codepoint(n)
  /// ```
  Object? convert_charref({
    required Object? name,
  }) =>
      getFunction("convert_charref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## convert_codepoint
  ///
  /// ### python source
  /// ```py
  /// def convert_codepoint(self, codepoint):
  ///         return chr(codepoint)
  /// ```
  Object? convert_codepoint({
    required Object? codepoint,
  }) =>
      getFunction("convert_codepoint").call(
        <Object?>[
          codepoint,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## convert_entityref
  ///
  /// ### python docstring
  ///
  /// Convert entity references.
  ///
  /// As an alternative to overriding this method; one can tailor the
  /// results by setting up the self.entitydefs mapping appropriately.
  ///
  /// ### python source
  /// ```py
  /// def convert_entityref(self, name):
  ///         """Convert entity references.
  ///
  ///         As an alternative to overriding this method; one can tailor the
  ///         results by setting up the self.entitydefs mapping appropriately.
  ///         """
  ///         table = self.entitydefs
  ///         if name in table:
  ///             return table[name]
  ///         else:
  ///             return
  /// ```
  Object? convert_entityref({
    required Object? name,
  }) =>
      getFunction("convert_entityref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## error
  ///
  /// ### python source
  /// ```py
  /// def error(self, message):
  ///         raise SGMLParseError(message)
  /// ```
  Object? error({
    required Object? message,
  }) =>
      getFunction("error").call(
        <Object?>[
          message,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## feed
  ///
  /// ### python docstring
  ///
  /// Feed some data to the parser.
  ///
  ///         Call this as often as you want, with as little or as much text
  ///         as you want (may include '
  /// ').  (This just saves the text,
  ///         all the processing is done by goahead().)
  ///
  /// ### python source
  /// ```py
  /// def feed(self, data):
  ///         """Feed some data to the parser.
  ///
  ///         Call this as often as you want, with as little or as much text
  ///         as you want (may include '\n').  (This just saves the text,
  ///         all the processing is done by goahead().)
  ///         """
  ///
  ///         self.rawdata = self.rawdata + data
  ///         self.goahead(0)
  /// ```
  Object? feed({
    required Object? data,
  }) =>
      getFunction("feed").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_endtag
  ///
  /// ### python source
  /// ```py
  /// def finish_endtag(self, tag):
  ///         if not tag:
  ///             found = len(self.stack) - 1
  ///             if found < 0:
  ///                 self.unknown_endtag(tag)
  ///                 return
  ///         else:
  ///             if tag not in self.stack:
  ///                 try:
  ///                     method = getattr(self, 'end_' + tag)
  ///                 except AttributeError:
  ///                     self.unknown_endtag(tag)
  ///                 else:
  ///                     self.report_unbalanced(tag)
  ///                 return
  ///             found = len(self.stack)
  ///             for i in range(found):
  ///                 if self.stack[i] == tag: found = i
  ///         while len(self.stack) > found:
  ///             tag = self.stack[-1]
  ///             try:
  ///                 method = getattr(self, 'end_' + tag)
  ///             except AttributeError:
  ///                 method = None
  ///             if method:
  ///                 self.handle_endtag(tag, method)
  ///             else:
  ///                 self.unknown_endtag(tag)
  ///             del self.stack[-1]
  /// ```
  Object? finish_endtag({
    required Object? tag,
  }) =>
      getFunction("finish_endtag").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_shorttag
  ///
  /// ### python source
  /// ```py
  /// def finish_shorttag(self, tag, data):
  ///         self.finish_starttag(tag, [])
  ///         self.handle_data(data)
  ///         self.finish_endtag(tag)
  /// ```
  Object? finish_shorttag({
    required Object? tag,
    required Object? data,
  }) =>
      getFunction("finish_shorttag").call(
        <Object?>[
          tag,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_starttag
  ///
  /// ### python source
  /// ```py
  /// def finish_starttag(self, tag, attrs):
  ///         try:
  ///             method = getattr(self, 'start_' + tag)
  ///         except AttributeError:
  ///             try:
  ///                 method = getattr(self, 'do_' + tag)
  ///             except AttributeError:
  ///                 self.unknown_starttag(tag, attrs)
  ///                 return -1
  ///             else:
  ///                 self.handle_starttag(tag, method, attrs)
  ///                 return 0
  ///         else:
  ///             self.stack.append(tag)
  ///             self.handle_starttag(tag, method, attrs)
  ///             return 1
  /// ```
  Object? finish_starttag({
    required Object? tag,
    required Object? attrs,
  }) =>
      getFunction("finish_starttag").call(
        <Object?>[
          tag,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## get_starttag_text
  ///
  /// ### python source
  /// ```py
  /// def get_starttag_text(self):
  ///         return self.__starttag_text
  /// ```
  Object? get_starttag_text() => getFunction("get_starttag_text").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## goahead
  ///
  /// ### python source
  /// ```py
  /// def goahead(self, end):
  ///         rawdata = self.rawdata
  ///         i = 0
  ///         n = len(rawdata)
  ///         while i < n:
  ///             if self.nomoretags:
  ///                 self.handle_data(rawdata[i:n])
  ///                 i = n
  ///                 break
  ///             match = interesting.search(rawdata, i)
  ///             if match: j = match.start()
  ///             else: j = n
  ///             if i < j:
  ///                 self.handle_data(rawdata[i:j])
  ///             i = j
  ///             if i == n: break
  ///             if rawdata[i] == '<':
  ///                 if starttagopen.match(rawdata, i):
  ///                     if self.literal:
  ///                         self.handle_data(rawdata[i])
  ///                         i = i+1
  ///                         continue
  ///                     k = self.parse_starttag(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///                 if rawdata.startswith("</", i):
  ///                     k = self.parse_endtag(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     self.literal = 0
  ///                     continue
  ///                 if self.literal:
  ///                     if n > (i + 1):
  ///                         self.handle_data("<")
  ///                         i = i+1
  ///                     else:
  ///                         # incomplete
  ///                         break
  ///                     continue
  ///                 if rawdata.startswith("<!--", i):
  ///                         # Strictly speaking, a comment is --.*--
  ///                         # within a declaration tag <!...>.
  ///                         # This should be removed,
  ///                         # and comments handled only in parse_declaration.
  ///                     k = self.parse_comment(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///                 if rawdata.startswith("<?", i):
  ///                     k = self.parse_pi(i)
  ///                     if k < 0: break
  ///                     i = i+k
  ///                     continue
  ///                 if rawdata.startswith("<!", i):
  ///                     # This is some sort of declaration; in "HTML as
  ///                     # deployed," this should only be the document type
  ///                     # declaration ("<!DOCTYPE html...>").
  ///                     k = self.parse_declaration(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///             elif rawdata[i] == '&':
  ///                 if self.literal:
  ///                     self.handle_data(rawdata[i])
  ///                     i = i+1
  ///                     continue
  ///                 match = charref.match(rawdata, i)
  ///                 if match:
  ///                     name = match.group(1)
  ///                     self.handle_charref(name)
  ///                     i = match.end(0)
  ///                     if rawdata[i-1] != ';': i = i-1
  ///                     continue
  ///                 match = entityref.match(rawdata, i)
  ///                 if match:
  ///                     name = match.group(1)
  ///                     self.handle_entityref(name)
  ///                     i = match.end(0)
  ///                     if rawdata[i-1] != ';': i = i-1
  ///                     continue
  ///             else:
  ///                 self.error('neither < nor & ??')
  ///             # We get here only if incomplete matches but
  ///             # nothing else
  ///             match = incomplete.match(rawdata, i)
  ///             if not match:
  ///                 self.handle_data(rawdata[i])
  ///                 i = i+1
  ///                 continue
  ///             j = match.end(0)
  ///             if j == n:
  ///                 break # Really incomplete
  ///             self.handle_data(rawdata[i:j])
  ///             i = j
  ///         # end while
  ///         if end and i < n:
  ///             self.handle_data(rawdata[i:n])
  ///             i = n
  ///         self.rawdata = rawdata[i:]
  ///         # XXX if end: check for empty stack
  /// ```
  Object? goahead({
    required Object? end,
  }) =>
      getFunction("goahead").call(
        <Object?>[
          end,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_charref
  ///
  /// ### python docstring
  ///
  /// Handle character reference, no need to override.
  ///
  /// ### python source
  /// ```py
  /// def handle_charref(self, name):
  ///         """Handle character reference, no need to override."""
  ///         replacement = self.convert_charref(name)
  ///         if replacement is None:
  ///             self.unknown_charref(name)
  ///         else:
  ///             self.handle_data(replacement)
  /// ```
  Object? handle_charref({
    required Object? name,
  }) =>
      getFunction("handle_charref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_comment
  ///
  /// ### python source
  /// ```py
  /// def handle_comment(self, data):
  ///         pass
  /// ```
  Object? handle_comment({
    required Object? data,
  }) =>
      getFunction("handle_comment").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_data
  ///
  /// ### python source
  /// ```py
  /// def handle_data(self, data):
  ///         pass
  /// ```
  Object? handle_data({
    required Object? data,
  }) =>
      getFunction("handle_data").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_decl
  ///
  /// ### python source
  /// ```py
  /// def handle_decl(self, decl):
  ///         pass
  /// ```
  Object? handle_decl({
    required Object? decl,
  }) =>
      getFunction("handle_decl").call(
        <Object?>[
          decl,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_endtag
  ///
  /// ### python source
  /// ```py
  /// def handle_endtag(self, tag, method):
  ///         method()
  /// ```
  Object? handle_endtag({
    required Object? tag,
    required Object? method,
  }) =>
      getFunction("handle_endtag").call(
        <Object?>[
          tag,
          method,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_entityref
  ///
  /// ### python docstring
  ///
  /// Handle entity references, no need to override.
  ///
  /// ### python source
  /// ```py
  /// def handle_entityref(self, name):
  ///         """Handle entity references, no need to override."""
  ///         replacement = self.convert_entityref(name)
  ///         if replacement is None:
  ///             self.unknown_entityref(name)
  ///         else:
  ///             self.handle_data(replacement)
  /// ```
  Object? handle_entityref({
    required Object? name,
  }) =>
      getFunction("handle_entityref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_pi
  ///
  /// ### python source
  /// ```py
  /// def handle_pi(self, data):
  ///         pass
  /// ```
  Object? handle_pi({
    required Object? data,
  }) =>
      getFunction("handle_pi").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_starttag
  ///
  /// ### python source
  /// ```py
  /// def handle_starttag(self, tag, method, attrs):
  ///         method(attrs)
  /// ```
  Object? handle_starttag({
    required Object? tag,
    required Object? method,
    required Object? attrs,
  }) =>
      getFunction("handle_starttag").call(
        <Object?>[
          tag,
          method,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_endtag
  ///
  /// ### python source
  /// ```py
  /// def parse_endtag(self, i):
  ///         rawdata = self.rawdata
  ///         match = endbracket.search(rawdata, i+1)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         tag = rawdata[i+2:j].strip().lower()
  ///         if rawdata[j] == '>':
  ///             j = j+1
  ///         self.finish_endtag(tag)
  ///         return j
  /// ```
  Object? parse_endtag({
    required Object? i,
  }) =>
      getFunction("parse_endtag").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_pi
  ///
  /// ### python source
  /// ```py
  /// def parse_pi(self, i):
  ///         rawdata = self.rawdata
  ///         if rawdata[i:i+2] != '<?':
  ///             self.error('unexpected call to parse_pi()')
  ///         match = piclose.search(rawdata, i+2)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         self.handle_pi(rawdata[i+2: j])
  ///         j = match.end(0)
  ///         return j-i
  /// ```
  Object? parse_pi({
    required Object? i,
  }) =>
      getFunction("parse_pi").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_starttag
  ///
  /// ### python source
  /// ```py
  /// def parse_starttag(self, i):
  ///         self.__starttag_text = None
  ///         start_pos = i
  ///         rawdata = self.rawdata
  ///         if shorttagopen.match(rawdata, i):
  ///             # SGML shorthand: <tag/data/ == <tag>data</tag>
  ///             # XXX Can data contain &... (entity or char refs)?
  ///             # XXX Can data contain < or > (tag characters)?
  ///             # XXX Can there be whitespace before the first /?
  ///             match = shorttag.match(rawdata, i)
  ///             if not match:
  ///                 return -1
  ///             tag, data = match.group(1, 2)
  ///             self.__starttag_text = '<%s/' % tag
  ///             tag = tag.lower()
  ///             k = match.end(0)
  ///             self.finish_shorttag(tag, data)
  ///             self.__starttag_text = rawdata[start_pos:match.end(1) + 1]
  ///             return k
  ///         # XXX The following should skip matching quotes (' or ")
  ///         # As a shortcut way to exit, this isn't so bad, but shouldn't
  ///         # be used to locate the actual end of the start tag since the
  ///         # < or > characters may be embedded in an attribute value.
  ///         match = endbracket.search(rawdata, i+1)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         # Now parse the data between i+1 and j into a tag and attrs
  ///         attrs = []
  ///         if rawdata[i:i+2] == '<>':
  ///             # SGML shorthand: <> == <last open tag seen>
  ///             k = j
  ///             tag = self.lasttag
  ///         else:
  ///             match = tagfind.match(rawdata, i+1)
  ///             if not match:
  ///                 self.error('unexpected call to parse_starttag')
  ///             k = match.end(0)
  ///             tag = rawdata[i+1:k].lower()
  ///             self.lasttag = tag
  ///         while k < j:
  ///             match = attrfind.match(rawdata, k)
  ///             if not match: break
  ///             attrname, rest, attrvalue = match.group(1, 2, 3)
  ///             if not rest:
  ///                 attrvalue = attrname
  ///             else:
  ///                 if (attrvalue[:1] == "'" == attrvalue[-1:] or
  ///                     attrvalue[:1] == '"' == attrvalue[-1:]):
  ///                     # strip quotes
  ///                     attrvalue = attrvalue[1:-1]
  ///                 attrvalue = self.entity_or_charref.sub(
  ///                     self._convert_ref, attrvalue)
  ///             attrs.append((attrname.lower(), attrvalue))
  ///             k = match.end(0)
  ///         if rawdata[j] == '>':
  ///             j = j+1
  ///         self.__starttag_text = rawdata[start_pos:j]
  ///         self.finish_starttag(tag, attrs)
  ///         return j
  /// ```
  Object? parse_starttag({
    required Object? i,
  }) =>
      getFunction("parse_starttag").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## report_unbalanced
  ///
  /// ### python source
  /// ```py
  /// def report_unbalanced(self, tag):
  ///         if self.verbose:
  ///             print('*** Unbalanced </' + tag + '>')
  ///             print('*** Stack:', self.stack)
  /// ```
  Object? report_unbalanced({
    required Object? tag,
  }) =>
      getFunction("report_unbalanced").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## reset
  ///
  /// ### python docstring
  ///
  /// Reset this instance. Loses all unprocessed data.
  ///
  /// ### python source
  /// ```py
  /// def reset(self):
  ///         """Reset this instance. Loses all unprocessed data."""
  ///         self.__starttag_text = None
  ///         self.rawdata = ''
  ///         self.stack = []
  ///         self.lasttag = '???'
  ///         self.nomoretags = 0
  ///         self.literal = 0
  ///         _markupbase.ParserBase.reset(self)
  /// ```
  Object? reset() => getFunction("reset").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## setliteral
  ///
  /// ### python docstring
  ///
  /// Enter literal mode (CDATA).
  ///
  /// Intended for derived classes only.
  ///
  /// ### python source
  /// ```py
  /// def setliteral(self, *args):
  ///         """Enter literal mode (CDATA).
  ///
  ///         Intended for derived classes only.
  ///         """
  ///         self.literal = 1
  /// ```
  Object? setliteral({
    List<Object?> args = const <Object?>[],
  }) =>
      getFunction("setliteral").call(
        <Object?>[
          ...args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## setnomoretags
  ///
  /// ### python docstring
  ///
  /// Enter literal mode (CDATA) till EOF.
  ///
  /// Intended for derived classes only.
  ///
  /// ### python source
  /// ```py
  /// def setnomoretags(self):
  ///         """Enter literal mode (CDATA) till EOF.
  ///
  ///         Intended for derived classes only.
  ///         """
  ///         self.nomoretags = self.literal = 1
  /// ```
  Object? setnomoretags() => getFunction("setnomoretags").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_charref
  ///
  /// ### python source
  /// ```py
  /// def unknown_charref(self, ref): pass
  /// ```
  Object? unknown_charref({
    required Object? ref,
  }) =>
      getFunction("unknown_charref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_endtag
  ///
  /// ### python source
  /// ```py
  /// def unknown_endtag(self, tag): pass
  /// ```
  Object? unknown_endtag({
    required Object? tag,
  }) =>
      getFunction("unknown_endtag").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_entityref
  ///
  /// ### python source
  /// ```py
  /// def unknown_entityref(self, ref): pass
  /// ```
  Object? unknown_entityref({
    required Object? ref,
  }) =>
      getFunction("unknown_entityref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_starttag
  ///
  /// ### python source
  /// ```py
  /// def unknown_starttag(self, tag, attrs): pass
  /// ```
  Object? unknown_starttag({
    required Object? tag,
    required Object? attrs,
  }) =>
      getFunction("unknown_starttag").call(
        <Object?>[
          tag,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## entity_or_charref (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get entity_or_charref => getAttribute("entity_or_charref");

  /// ## entity_or_charref (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set entity_or_charref(Object? entity_or_charref) =>
      setAttribute("entity_or_charref", entity_or_charref);

  /// ## entitydefs (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get entitydefs => getAttribute("entitydefs");

  /// ## entitydefs (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set entitydefs(Object? entitydefs) => setAttribute("entitydefs", entitydefs);

  /// ## verbose (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get verbose => getAttribute("verbose");

  /// ## verbose (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set verbose(Object? verbose) => setAttribute("verbose", verbose);
}

/// ## TestSGMLParser
///
/// ### python docstring
///
/// Parser base class which provides some common support methods used
/// by the SGML/HTML and XHTML parsers.
///
/// ### python source
/// ```py
/// class TestSGMLParser(SGMLParser):
///
///     def __init__(self, verbose=0):
///         self.testdata = ""
///         SGMLParser.__init__(self, verbose)
///
///     def handle_data(self, data):
///         self.testdata = self.testdata + data
///         if len(repr(self.testdata)) >= 70:
///             self.flush()
///
///     def flush(self):
///         data = self.testdata
///         if data:
///             self.testdata = ""
///             print('data:', repr(data))
///
///     def handle_comment(self, data):
///         self.flush()
///         r = repr(data)
///         if len(r) > 68:
///             r = r[:32] + '...' + r[-32:]
///         print('comment:', r)
///
///     def unknown_starttag(self, tag, attrs):
///         self.flush()
///         if not attrs:
///             print('start tag: <' + tag + '>')
///         else:
///             print('start tag: <' + tag, end=' ')
///             for name, value in attrs:
///                 print(name + '=' + '"' + value + '"', end=' ')
///             print('>')
///
///     def unknown_endtag(self, tag):
///         self.flush()
///         print('end tag: </' + tag + '>')
///
///     def unknown_entityref(self, ref):
///         self.flush()
///         print('*** unknown entity ref: &' + ref + ';')
///
///     def unknown_charref(self, ref):
///         self.flush()
///         print('*** unknown char ref: &#' + ref + ';')
///
///     def unknown_decl(self, data):
///         self.flush()
///         print('*** unknown decl: [' + data + ']')
///
///     def close(self):
///         SGMLParser.close(self)
///         self.flush()
/// ```
final class TestSGMLParser extends PythonClass {
  factory TestSGMLParser({
    Object? verbose = 0,
  }) =>
      PythonFfiDart.instance.importClass(
        "sgmllib",
        "TestSGMLParser",
        TestSGMLParser.from,
        <Object?>[
          verbose,
        ],
        <String, Object?>{},
      );

  TestSGMLParser.from(super.pythonClass) : super.from();

  /// ## close
  ///
  /// ### python docstring
  ///
  /// Handle the remaining data.
  ///
  /// ### python source
  /// ```py
  /// def close(self):
  ///         SGMLParser.close(self)
  ///         self.flush()
  /// ```
  Object? close() => getFunction("close").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## convert_charref
  ///
  /// ### python docstring
  ///
  /// Convert character reference, may be overridden.
  ///
  /// ### python source
  /// ```py
  /// def convert_charref(self, name):
  ///         """Convert character reference, may be overridden."""
  ///         try:
  ///             n = int(name)
  ///         except ValueError:
  ///             return
  ///         if not 0 <= n <= 127:
  ///             return
  ///         return self.convert_codepoint(n)
  /// ```
  Object? convert_charref({
    required Object? name,
  }) =>
      getFunction("convert_charref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## convert_codepoint
  ///
  /// ### python source
  /// ```py
  /// def convert_codepoint(self, codepoint):
  ///         return chr(codepoint)
  /// ```
  Object? convert_codepoint({
    required Object? codepoint,
  }) =>
      getFunction("convert_codepoint").call(
        <Object?>[
          codepoint,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## convert_entityref
  ///
  /// ### python docstring
  ///
  /// Convert entity references.
  ///
  /// As an alternative to overriding this method; one can tailor the
  /// results by setting up the self.entitydefs mapping appropriately.
  ///
  /// ### python source
  /// ```py
  /// def convert_entityref(self, name):
  ///         """Convert entity references.
  ///
  ///         As an alternative to overriding this method; one can tailor the
  ///         results by setting up the self.entitydefs mapping appropriately.
  ///         """
  ///         table = self.entitydefs
  ///         if name in table:
  ///             return table[name]
  ///         else:
  ///             return
  /// ```
  Object? convert_entityref({
    required Object? name,
  }) =>
      getFunction("convert_entityref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## error
  ///
  /// ### python source
  /// ```py
  /// def error(self, message):
  ///         raise SGMLParseError(message)
  /// ```
  Object? error({
    required Object? message,
  }) =>
      getFunction("error").call(
        <Object?>[
          message,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## feed
  ///
  /// ### python docstring
  ///
  /// Feed some data to the parser.
  ///
  ///         Call this as often as you want, with as little or as much text
  ///         as you want (may include '
  /// ').  (This just saves the text,
  ///         all the processing is done by goahead().)
  ///
  /// ### python source
  /// ```py
  /// def feed(self, data):
  ///         """Feed some data to the parser.
  ///
  ///         Call this as often as you want, with as little or as much text
  ///         as you want (may include '\n').  (This just saves the text,
  ///         all the processing is done by goahead().)
  ///         """
  ///
  ///         self.rawdata = self.rawdata + data
  ///         self.goahead(0)
  /// ```
  Object? feed({
    required Object? data,
  }) =>
      getFunction("feed").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_endtag
  ///
  /// ### python source
  /// ```py
  /// def finish_endtag(self, tag):
  ///         if not tag:
  ///             found = len(self.stack) - 1
  ///             if found < 0:
  ///                 self.unknown_endtag(tag)
  ///                 return
  ///         else:
  ///             if tag not in self.stack:
  ///                 try:
  ///                     method = getattr(self, 'end_' + tag)
  ///                 except AttributeError:
  ///                     self.unknown_endtag(tag)
  ///                 else:
  ///                     self.report_unbalanced(tag)
  ///                 return
  ///             found = len(self.stack)
  ///             for i in range(found):
  ///                 if self.stack[i] == tag: found = i
  ///         while len(self.stack) > found:
  ///             tag = self.stack[-1]
  ///             try:
  ///                 method = getattr(self, 'end_' + tag)
  ///             except AttributeError:
  ///                 method = None
  ///             if method:
  ///                 self.handle_endtag(tag, method)
  ///             else:
  ///                 self.unknown_endtag(tag)
  ///             del self.stack[-1]
  /// ```
  Object? finish_endtag({
    required Object? tag,
  }) =>
      getFunction("finish_endtag").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_shorttag
  ///
  /// ### python source
  /// ```py
  /// def finish_shorttag(self, tag, data):
  ///         self.finish_starttag(tag, [])
  ///         self.handle_data(data)
  ///         self.finish_endtag(tag)
  /// ```
  Object? finish_shorttag({
    required Object? tag,
    required Object? data,
  }) =>
      getFunction("finish_shorttag").call(
        <Object?>[
          tag,
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## finish_starttag
  ///
  /// ### python source
  /// ```py
  /// def finish_starttag(self, tag, attrs):
  ///         try:
  ///             method = getattr(self, 'start_' + tag)
  ///         except AttributeError:
  ///             try:
  ///                 method = getattr(self, 'do_' + tag)
  ///             except AttributeError:
  ///                 self.unknown_starttag(tag, attrs)
  ///                 return -1
  ///             else:
  ///                 self.handle_starttag(tag, method, attrs)
  ///                 return 0
  ///         else:
  ///             self.stack.append(tag)
  ///             self.handle_starttag(tag, method, attrs)
  ///             return 1
  /// ```
  Object? finish_starttag({
    required Object? tag,
    required Object? attrs,
  }) =>
      getFunction("finish_starttag").call(
        <Object?>[
          tag,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## flush
  ///
  /// ### python source
  /// ```py
  /// def flush(self):
  ///         data = self.testdata
  ///         if data:
  ///             self.testdata = ""
  ///             print('data:', repr(data))
  /// ```
  Object? flush() => getFunction("flush").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## get_starttag_text
  ///
  /// ### python source
  /// ```py
  /// def get_starttag_text(self):
  ///         return self.__starttag_text
  /// ```
  Object? get_starttag_text() => getFunction("get_starttag_text").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## goahead
  ///
  /// ### python source
  /// ```py
  /// def goahead(self, end):
  ///         rawdata = self.rawdata
  ///         i = 0
  ///         n = len(rawdata)
  ///         while i < n:
  ///             if self.nomoretags:
  ///                 self.handle_data(rawdata[i:n])
  ///                 i = n
  ///                 break
  ///             match = interesting.search(rawdata, i)
  ///             if match: j = match.start()
  ///             else: j = n
  ///             if i < j:
  ///                 self.handle_data(rawdata[i:j])
  ///             i = j
  ///             if i == n: break
  ///             if rawdata[i] == '<':
  ///                 if starttagopen.match(rawdata, i):
  ///                     if self.literal:
  ///                         self.handle_data(rawdata[i])
  ///                         i = i+1
  ///                         continue
  ///                     k = self.parse_starttag(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///                 if rawdata.startswith("</", i):
  ///                     k = self.parse_endtag(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     self.literal = 0
  ///                     continue
  ///                 if self.literal:
  ///                     if n > (i + 1):
  ///                         self.handle_data("<")
  ///                         i = i+1
  ///                     else:
  ///                         # incomplete
  ///                         break
  ///                     continue
  ///                 if rawdata.startswith("<!--", i):
  ///                         # Strictly speaking, a comment is --.*--
  ///                         # within a declaration tag <!...>.
  ///                         # This should be removed,
  ///                         # and comments handled only in parse_declaration.
  ///                     k = self.parse_comment(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///                 if rawdata.startswith("<?", i):
  ///                     k = self.parse_pi(i)
  ///                     if k < 0: break
  ///                     i = i+k
  ///                     continue
  ///                 if rawdata.startswith("<!", i):
  ///                     # This is some sort of declaration; in "HTML as
  ///                     # deployed," this should only be the document type
  ///                     # declaration ("<!DOCTYPE html...>").
  ///                     k = self.parse_declaration(i)
  ///                     if k < 0: break
  ///                     i = k
  ///                     continue
  ///             elif rawdata[i] == '&':
  ///                 if self.literal:
  ///                     self.handle_data(rawdata[i])
  ///                     i = i+1
  ///                     continue
  ///                 match = charref.match(rawdata, i)
  ///                 if match:
  ///                     name = match.group(1)
  ///                     self.handle_charref(name)
  ///                     i = match.end(0)
  ///                     if rawdata[i-1] != ';': i = i-1
  ///                     continue
  ///                 match = entityref.match(rawdata, i)
  ///                 if match:
  ///                     name = match.group(1)
  ///                     self.handle_entityref(name)
  ///                     i = match.end(0)
  ///                     if rawdata[i-1] != ';': i = i-1
  ///                     continue
  ///             else:
  ///                 self.error('neither < nor & ??')
  ///             # We get here only if incomplete matches but
  ///             # nothing else
  ///             match = incomplete.match(rawdata, i)
  ///             if not match:
  ///                 self.handle_data(rawdata[i])
  ///                 i = i+1
  ///                 continue
  ///             j = match.end(0)
  ///             if j == n:
  ///                 break # Really incomplete
  ///             self.handle_data(rawdata[i:j])
  ///             i = j
  ///         # end while
  ///         if end and i < n:
  ///             self.handle_data(rawdata[i:n])
  ///             i = n
  ///         self.rawdata = rawdata[i:]
  ///         # XXX if end: check for empty stack
  /// ```
  Object? goahead({
    required Object? end,
  }) =>
      getFunction("goahead").call(
        <Object?>[
          end,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_charref
  ///
  /// ### python docstring
  ///
  /// Handle character reference, no need to override.
  ///
  /// ### python source
  /// ```py
  /// def handle_charref(self, name):
  ///         """Handle character reference, no need to override."""
  ///         replacement = self.convert_charref(name)
  ///         if replacement is None:
  ///             self.unknown_charref(name)
  ///         else:
  ///             self.handle_data(replacement)
  /// ```
  Object? handle_charref({
    required Object? name,
  }) =>
      getFunction("handle_charref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_comment
  ///
  /// ### python source
  /// ```py
  /// def handle_comment(self, data):
  ///         self.flush()
  ///         r = repr(data)
  ///         if len(r) > 68:
  ///             r = r[:32] + '...' + r[-32:]
  ///         print('comment:', r)
  /// ```
  Object? handle_comment({
    required Object? data,
  }) =>
      getFunction("handle_comment").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_data
  ///
  /// ### python source
  /// ```py
  /// def handle_data(self, data):
  ///         self.testdata = self.testdata + data
  ///         if len(repr(self.testdata)) >= 70:
  ///             self.flush()
  /// ```
  Object? handle_data({
    required Object? data,
  }) =>
      getFunction("handle_data").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_decl
  ///
  /// ### python source
  /// ```py
  /// def handle_decl(self, decl):
  ///         pass
  /// ```
  Object? handle_decl({
    required Object? decl,
  }) =>
      getFunction("handle_decl").call(
        <Object?>[
          decl,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_endtag
  ///
  /// ### python source
  /// ```py
  /// def handle_endtag(self, tag, method):
  ///         method()
  /// ```
  Object? handle_endtag({
    required Object? tag,
    required Object? method,
  }) =>
      getFunction("handle_endtag").call(
        <Object?>[
          tag,
          method,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_entityref
  ///
  /// ### python docstring
  ///
  /// Handle entity references, no need to override.
  ///
  /// ### python source
  /// ```py
  /// def handle_entityref(self, name):
  ///         """Handle entity references, no need to override."""
  ///         replacement = self.convert_entityref(name)
  ///         if replacement is None:
  ///             self.unknown_entityref(name)
  ///         else:
  ///             self.handle_data(replacement)
  /// ```
  Object? handle_entityref({
    required Object? name,
  }) =>
      getFunction("handle_entityref").call(
        <Object?>[
          name,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_pi
  ///
  /// ### python source
  /// ```py
  /// def handle_pi(self, data):
  ///         pass
  /// ```
  Object? handle_pi({
    required Object? data,
  }) =>
      getFunction("handle_pi").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_starttag
  ///
  /// ### python source
  /// ```py
  /// def handle_starttag(self, tag, method, attrs):
  ///         method(attrs)
  /// ```
  Object? handle_starttag({
    required Object? tag,
    required Object? method,
    required Object? attrs,
  }) =>
      getFunction("handle_starttag").call(
        <Object?>[
          tag,
          method,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_endtag
  ///
  /// ### python source
  /// ```py
  /// def parse_endtag(self, i):
  ///         rawdata = self.rawdata
  ///         match = endbracket.search(rawdata, i+1)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         tag = rawdata[i+2:j].strip().lower()
  ///         if rawdata[j] == '>':
  ///             j = j+1
  ///         self.finish_endtag(tag)
  ///         return j
  /// ```
  Object? parse_endtag({
    required Object? i,
  }) =>
      getFunction("parse_endtag").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_pi
  ///
  /// ### python source
  /// ```py
  /// def parse_pi(self, i):
  ///         rawdata = self.rawdata
  ///         if rawdata[i:i+2] != '<?':
  ///             self.error('unexpected call to parse_pi()')
  ///         match = piclose.search(rawdata, i+2)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         self.handle_pi(rawdata[i+2: j])
  ///         j = match.end(0)
  ///         return j-i
  /// ```
  Object? parse_pi({
    required Object? i,
  }) =>
      getFunction("parse_pi").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse_starttag
  ///
  /// ### python source
  /// ```py
  /// def parse_starttag(self, i):
  ///         self.__starttag_text = None
  ///         start_pos = i
  ///         rawdata = self.rawdata
  ///         if shorttagopen.match(rawdata, i):
  ///             # SGML shorthand: <tag/data/ == <tag>data</tag>
  ///             # XXX Can data contain &... (entity or char refs)?
  ///             # XXX Can data contain < or > (tag characters)?
  ///             # XXX Can there be whitespace before the first /?
  ///             match = shorttag.match(rawdata, i)
  ///             if not match:
  ///                 return -1
  ///             tag, data = match.group(1, 2)
  ///             self.__starttag_text = '<%s/' % tag
  ///             tag = tag.lower()
  ///             k = match.end(0)
  ///             self.finish_shorttag(tag, data)
  ///             self.__starttag_text = rawdata[start_pos:match.end(1) + 1]
  ///             return k
  ///         # XXX The following should skip matching quotes (' or ")
  ///         # As a shortcut way to exit, this isn't so bad, but shouldn't
  ///         # be used to locate the actual end of the start tag since the
  ///         # < or > characters may be embedded in an attribute value.
  ///         match = endbracket.search(rawdata, i+1)
  ///         if not match:
  ///             return -1
  ///         j = match.start(0)
  ///         # Now parse the data between i+1 and j into a tag and attrs
  ///         attrs = []
  ///         if rawdata[i:i+2] == '<>':
  ///             # SGML shorthand: <> == <last open tag seen>
  ///             k = j
  ///             tag = self.lasttag
  ///         else:
  ///             match = tagfind.match(rawdata, i+1)
  ///             if not match:
  ///                 self.error('unexpected call to parse_starttag')
  ///             k = match.end(0)
  ///             tag = rawdata[i+1:k].lower()
  ///             self.lasttag = tag
  ///         while k < j:
  ///             match = attrfind.match(rawdata, k)
  ///             if not match: break
  ///             attrname, rest, attrvalue = match.group(1, 2, 3)
  ///             if not rest:
  ///                 attrvalue = attrname
  ///             else:
  ///                 if (attrvalue[:1] == "'" == attrvalue[-1:] or
  ///                     attrvalue[:1] == '"' == attrvalue[-1:]):
  ///                     # strip quotes
  ///                     attrvalue = attrvalue[1:-1]
  ///                 attrvalue = self.entity_or_charref.sub(
  ///                     self._convert_ref, attrvalue)
  ///             attrs.append((attrname.lower(), attrvalue))
  ///             k = match.end(0)
  ///         if rawdata[j] == '>':
  ///             j = j+1
  ///         self.__starttag_text = rawdata[start_pos:j]
  ///         self.finish_starttag(tag, attrs)
  ///         return j
  /// ```
  Object? parse_starttag({
    required Object? i,
  }) =>
      getFunction("parse_starttag").call(
        <Object?>[
          i,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## report_unbalanced
  ///
  /// ### python source
  /// ```py
  /// def report_unbalanced(self, tag):
  ///         if self.verbose:
  ///             print('*** Unbalanced </' + tag + '>')
  ///             print('*** Stack:', self.stack)
  /// ```
  Object? report_unbalanced({
    required Object? tag,
  }) =>
      getFunction("report_unbalanced").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## reset
  ///
  /// ### python docstring
  ///
  /// Reset this instance. Loses all unprocessed data.
  ///
  /// ### python source
  /// ```py
  /// def reset(self):
  ///         """Reset this instance. Loses all unprocessed data."""
  ///         self.__starttag_text = None
  ///         self.rawdata = ''
  ///         self.stack = []
  ///         self.lasttag = '???'
  ///         self.nomoretags = 0
  ///         self.literal = 0
  ///         _markupbase.ParserBase.reset(self)
  /// ```
  Object? reset() => getFunction("reset").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## setliteral
  ///
  /// ### python docstring
  ///
  /// Enter literal mode (CDATA).
  ///
  /// Intended for derived classes only.
  ///
  /// ### python source
  /// ```py
  /// def setliteral(self, *args):
  ///         """Enter literal mode (CDATA).
  ///
  ///         Intended for derived classes only.
  ///         """
  ///         self.literal = 1
  /// ```
  Object? setliteral({
    List<Object?> args = const <Object?>[],
  }) =>
      getFunction("setliteral").call(
        <Object?>[
          ...args,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## setnomoretags
  ///
  /// ### python docstring
  ///
  /// Enter literal mode (CDATA) till EOF.
  ///
  /// Intended for derived classes only.
  ///
  /// ### python source
  /// ```py
  /// def setnomoretags(self):
  ///         """Enter literal mode (CDATA) till EOF.
  ///
  ///         Intended for derived classes only.
  ///         """
  ///         self.nomoretags = self.literal = 1
  /// ```
  Object? setnomoretags() => getFunction("setnomoretags").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_charref
  ///
  /// ### python source
  /// ```py
  /// def unknown_charref(self, ref):
  ///         self.flush()
  ///         print('*** unknown char ref: &#' + ref + ';')
  /// ```
  Object? unknown_charref({
    required Object? ref,
  }) =>
      getFunction("unknown_charref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_decl
  ///
  /// ### python source
  /// ```py
  /// def unknown_decl(self, data):
  ///         self.flush()
  ///         print('*** unknown decl: [' + data + ']')
  /// ```
  Object? unknown_decl({
    required Object? data,
  }) =>
      getFunction("unknown_decl").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_endtag
  ///
  /// ### python source
  /// ```py
  /// def unknown_endtag(self, tag):
  ///         self.flush()
  ///         print('end tag: </' + tag + '>')
  /// ```
  Object? unknown_endtag({
    required Object? tag,
  }) =>
      getFunction("unknown_endtag").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_entityref
  ///
  /// ### python source
  /// ```py
  /// def unknown_entityref(self, ref):
  ///         self.flush()
  ///         print('*** unknown entity ref: &' + ref + ';')
  /// ```
  Object? unknown_entityref({
    required Object? ref,
  }) =>
      getFunction("unknown_entityref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_starttag
  ///
  /// ### python source
  /// ```py
  /// def unknown_starttag(self, tag, attrs):
  ///         self.flush()
  ///         if not attrs:
  ///             print('start tag: <' + tag + '>')
  ///         else:
  ///             print('start tag: <' + tag, end=' ')
  ///             for name, value in attrs:
  ///                 print(name + '=' + '"' + value + '"', end=' ')
  ///             print('>')
  /// ```
  Object? unknown_starttag({
    required Object? tag,
    required Object? attrs,
  }) =>
      getFunction("unknown_starttag").call(
        <Object?>[
          tag,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## entity_or_charref (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get entity_or_charref => getAttribute("entity_or_charref");

  /// ## entity_or_charref (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set entity_or_charref(Object? entity_or_charref) =>
      setAttribute("entity_or_charref", entity_or_charref);

  /// ## entitydefs (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get entitydefs => getAttribute("entitydefs");

  /// ## entitydefs (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set entitydefs(Object? entitydefs) => setAttribute("entitydefs", entitydefs);

  /// ## testdata (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get testdata => getAttribute("testdata");

  /// ## testdata (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set testdata(Object? testdata) => setAttribute("testdata", testdata);
}

/// ## sgml
///
/// ### python source
/// ```py
/// # Copyright 2010-2022 Kurt McKee <contactme@kurtmckee.org>
/// # Copyright 2002-2008 Mark Pilgrim
/// # All rights reserved.
/// #
/// # This file is a part of feedparser.
/// #
/// # Redistribution and use in source and binary forms, with or without
/// # modification, are permitted provided that the following conditions are met:
/// #
/// # * Redistributions of source code must retain the above copyright notice,
/// #   this list of conditions and the following disclaimer.
/// # * Redistributions in binary form must reproduce the above copyright notice,
/// #   this list of conditions and the following disclaimer in the documentation
/// #   and/or other materials provided with the distribution.
/// #
/// # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'
/// # AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
/// # IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
/// # ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
/// # LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
/// # CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
/// # SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
/// # INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
/// # CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
/// # ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
/// # POSSIBILITY OF SUCH DAMAGE.
///
/// import re
///
/// import sgmllib
///
/// __all__ = [
///     'sgmllib',
///     'charref',
///     'tagfind',
///     'attrfind',
///     'entityref',
///     'incomplete',
///     'interesting',
///     'shorttag',
///     'shorttagopen',
///     'starttagopen',
///     'endbracket',
/// ]
///
/// # sgmllib defines a number of module-level regular expressions that are
/// # insufficient for the XML parsing feedparser needs. Rather than modify
/// # the variables directly in sgmllib, they're defined here using the same
/// # names, and the compiled code objects of several sgmllib.SGMLParser
/// # methods are copied into _BaseHTMLProcessor so that they execute in
/// # feedparser's scope instead of sgmllib's scope.
/// charref = re.compile(r'&#(\d+|[xX][0-9a-fA-F]+);')
/// tagfind = re.compile(r'[a-zA-Z][-_.:a-zA-Z0-9]*')
/// attrfind = re.compile(
///     r"""\s*([a-zA-Z_][-:.a-zA-Z_0-9]*)[$]?(\s*=\s*"""
///     r"""('[^']*'|"[^"]*"|[][\-a-zA-Z0-9./,:;+*%?!&$()_#=~'"@]*))?"""
/// )
///
/// # Unfortunately, these must be copied over to prevent NameError exceptions
/// entityref = sgmllib.entityref
/// incomplete = sgmllib.incomplete
/// interesting = sgmllib.interesting
/// shorttag = sgmllib.shorttag
/// shorttagopen = sgmllib.shorttagopen
/// starttagopen = sgmllib.starttagopen
///
///
/// class _EndBracketRegEx:
///     def __init__(self):
///         # Overriding the built-in sgmllib.endbracket regex allows the
///         # parser to find angle brackets embedded in element attributes.
///         self.endbracket = re.compile(
///             r'('
///             r"""[^'"<>]"""
///             r"""|"[^"]*"(?=>|/|\s|\w+=)"""
///             r"""|'[^']*'(?=>|/|\s|\w+=))*(?=[<>])"""
///             r"""|.*?(?=[<>]"""
///             r')'
///         )
///
///     def search(self, target, index=0):
///         match = self.endbracket.match(target, index)
///         if match is not None:
///             # Returning a new object in the calling thread's context
///             # resolves a thread-safety.
///             return EndBracketMatch(match)
///         return None
///
///
/// class EndBracketMatch:
///     def __init__(self, match):
///         self.match = match
///
///     def start(self, n):
///         return self.match.end(n)
///
///
/// endbracket = _EndBracketRegEx()
/// ```
final class sgml extends PythonModule {
  sgml.from(super.pythonModule) : super.from();

  static sgml import() => PythonFfiDart.instance.importModule(
        "feedparser.sgml",
        sgml.from,
      );

  /// ## endbracket (getter)
  Object? get endbracket => getAttribute("endbracket");

  /// ## endbracket (setter)
  set endbracket(Object? endbracket) => setAttribute("endbracket", endbracket);
}

/// ## sgmllib
///
/// ### python docstring
///
/// A parser for SGML, using the derived class as a static DTD.
///
/// ### python source
/// ```py
/// """A parser for SGML, using the derived class as a static DTD."""
///
/// # XXX This only supports those SGML features used by HTML.
///
/// # XXX There should be a way to distinguish between PCDATA (parsed
/// # character data -- the normal case), RCDATA (replaceable character
/// # data -- only char and entity references and end tags are special)
/// # and CDATA (character data -- only end tags are special).  RCDATA is
/// # not supported at all.
///
/// import _markupbase
/// import re
///
/// __all__ = ["SGMLParser", "SGMLParseError"]
///
/// # Regular expressions used for parsing
///
/// interesting = re.compile('[&<]')
/// incomplete = re.compile('&([a-zA-Z][a-zA-Z0-9]*|#[0-9]*)?|'
///                            '<([a-zA-Z][^<>]*|'
///                               '/([a-zA-Z][^<>]*)?|'
///                               '![^<>]*)?')
///
/// entityref = re.compile('&([a-zA-Z][-.a-zA-Z0-9]*)[^a-zA-Z0-9]')
/// charref = re.compile('&#([0-9]+)[^0-9]')
///
/// starttagopen = re.compile('<[>a-zA-Z]')
/// shorttagopen = re.compile('<[a-zA-Z][-.a-zA-Z0-9]*/')
/// shorttag = re.compile('<([a-zA-Z][-.a-zA-Z0-9]*)/([^/]*)/')
/// piclose = re.compile('>')
/// endbracket = re.compile('[<>]')
/// tagfind = re.compile('[a-zA-Z][-_.a-zA-Z0-9]*')
/// attrfind = re.compile(
///     r'\s*([a-zA-Z_][-:.a-zA-Z_0-9]*)(\s*=\s*'
///     r'(\'[^\']*\'|"[^"]*"|[][\-a-zA-Z0-9./,:;+*%?!&$\(\)_#=~\'"@]*))?')
///
///
/// class SGMLParseError(RuntimeError):
///     """Exception raised for all parse errors."""
///     pass
///
///
/// # SGML parser base class -- find tags and call handler functions.
/// # Usage: p = SGMLParser(); p.feed(data); ...; p.close().
/// # The dtd is defined by deriving a class which defines methods
/// # with special names to handle tags: start_foo and end_foo to handle
/// # <foo> and </foo>, respectively, or do_foo to handle <foo> by itself.
/// # (Tags are converted to lower case for this purpose.)  The data
/// # between tags is passed to the parser by calling self.handle_data()
/// # with some data as argument (the data may be split up in arbitrary
/// # chunks).  Entity references are passed by calling
/// # self.handle_entityref() with the entity reference as argument.
///
/// class SGMLParser(_markupbase.ParserBase):
///     # Definition of entities -- derived classes may override
///     entity_or_charref = re.compile('&(?:'
///       '([a-zA-Z][-.a-zA-Z0-9]*)|#([0-9]+)'
///       ')(;?)')
///
///     def __init__(self, verbose=0):
///         """Initialize and reset this instance."""
///         self.verbose = verbose
///         self.reset()
///
///     def reset(self):
///         """Reset this instance. Loses all unprocessed data."""
///         self.__starttag_text = None
///         self.rawdata = ''
///         self.stack = []
///         self.lasttag = '???'
///         self.nomoretags = 0
///         self.literal = 0
///         _markupbase.ParserBase.reset(self)
///
///     def setnomoretags(self):
///         """Enter literal mode (CDATA) till EOF.
///
///         Intended for derived classes only.
///         """
///         self.nomoretags = self.literal = 1
///
///     def setliteral(self, *args):
///         """Enter literal mode (CDATA).
///
///         Intended for derived classes only.
///         """
///         self.literal = 1
///
///     def feed(self, data):
///         """Feed some data to the parser.
///
///         Call this as often as you want, with as little or as much text
///         as you want (may include '\n').  (This just saves the text,
///         all the processing is done by goahead().)
///         """
///
///         self.rawdata = self.rawdata + data
///         self.goahead(0)
///
///     def close(self):
///         """Handle the remaining data."""
///         self.goahead(1)
///
///     def error(self, message):
///         raise SGMLParseError(message)
///
///     # Internal -- handle data as far as reasonable.  May leave state
///     # and data to be processed by a subsequent call.  If 'end' is
///     # true, force handling all data as if followed by EOF marker.
///     def goahead(self, end):
///         rawdata = self.rawdata
///         i = 0
///         n = len(rawdata)
///         while i < n:
///             if self.nomoretags:
///                 self.handle_data(rawdata[i:n])
///                 i = n
///                 break
///             match = interesting.search(rawdata, i)
///             if match: j = match.start()
///             else: j = n
///             if i < j:
///                 self.handle_data(rawdata[i:j])
///             i = j
///             if i == n: break
///             if rawdata[i] == '<':
///                 if starttagopen.match(rawdata, i):
///                     if self.literal:
///                         self.handle_data(rawdata[i])
///                         i = i+1
///                         continue
///                     k = self.parse_starttag(i)
///                     if k < 0: break
///                     i = k
///                     continue
///                 if rawdata.startswith("</", i):
///                     k = self.parse_endtag(i)
///                     if k < 0: break
///                     i = k
///                     self.literal = 0
///                     continue
///                 if self.literal:
///                     if n > (i + 1):
///                         self.handle_data("<")
///                         i = i+1
///                     else:
///                         # incomplete
///                         break
///                     continue
///                 if rawdata.startswith("<!--", i):
///                         # Strictly speaking, a comment is --.*--
///                         # within a declaration tag <!...>.
///                         # This should be removed,
///                         # and comments handled only in parse_declaration.
///                     k = self.parse_comment(i)
///                     if k < 0: break
///                     i = k
///                     continue
///                 if rawdata.startswith("<?", i):
///                     k = self.parse_pi(i)
///                     if k < 0: break
///                     i = i+k
///                     continue
///                 if rawdata.startswith("<!", i):
///                     # This is some sort of declaration; in "HTML as
///                     # deployed," this should only be the document type
///                     # declaration ("<!DOCTYPE html...>").
///                     k = self.parse_declaration(i)
///                     if k < 0: break
///                     i = k
///                     continue
///             elif rawdata[i] == '&':
///                 if self.literal:
///                     self.handle_data(rawdata[i])
///                     i = i+1
///                     continue
///                 match = charref.match(rawdata, i)
///                 if match:
///                     name = match.group(1)
///                     self.handle_charref(name)
///                     i = match.end(0)
///                     if rawdata[i-1] != ';': i = i-1
///                     continue
///                 match = entityref.match(rawdata, i)
///                 if match:
///                     name = match.group(1)
///                     self.handle_entityref(name)
///                     i = match.end(0)
///                     if rawdata[i-1] != ';': i = i-1
///                     continue
///             else:
///                 self.error('neither < nor & ??')
///             # We get here only if incomplete matches but
///             # nothing else
///             match = incomplete.match(rawdata, i)
///             if not match:
///                 self.handle_data(rawdata[i])
///                 i = i+1
///                 continue
///             j = match.end(0)
///             if j == n:
///                 break # Really incomplete
///             self.handle_data(rawdata[i:j])
///             i = j
///         # end while
///         if end and i < n:
///             self.handle_data(rawdata[i:n])
///             i = n
///         self.rawdata = rawdata[i:]
///         # XXX if end: check for empty stack
///
///     # Extensions for the DOCTYPE scanner:
///     _decl_otherchars = '='
///
///     # Internal -- parse processing instr, return length or -1 if not terminated
///     def parse_pi(self, i):
///         rawdata = self.rawdata
///         if rawdata[i:i+2] != '<?':
///             self.error('unexpected call to parse_pi()')
///         match = piclose.search(rawdata, i+2)
///         if not match:
///             return -1
///         j = match.start(0)
///         self.handle_pi(rawdata[i+2: j])
///         j = match.end(0)
///         return j-i
///
///     def get_starttag_text(self):
///         return self.__starttag_text
///
///     # Internal -- handle starttag, return length or -1 if not terminated
///     def parse_starttag(self, i):
///         self.__starttag_text = None
///         start_pos = i
///         rawdata = self.rawdata
///         if shorttagopen.match(rawdata, i):
///             # SGML shorthand: <tag/data/ == <tag>data</tag>
///             # XXX Can data contain &... (entity or char refs)?
///             # XXX Can data contain < or > (tag characters)?
///             # XXX Can there be whitespace before the first /?
///             match = shorttag.match(rawdata, i)
///             if not match:
///                 return -1
///             tag, data = match.group(1, 2)
///             self.__starttag_text = '<%s/' % tag
///             tag = tag.lower()
///             k = match.end(0)
///             self.finish_shorttag(tag, data)
///             self.__starttag_text = rawdata[start_pos:match.end(1) + 1]
///             return k
///         # XXX The following should skip matching quotes (' or ")
///         # As a shortcut way to exit, this isn't so bad, but shouldn't
///         # be used to locate the actual end of the start tag since the
///         # < or > characters may be embedded in an attribute value.
///         match = endbracket.search(rawdata, i+1)
///         if not match:
///             return -1
///         j = match.start(0)
///         # Now parse the data between i+1 and j into a tag and attrs
///         attrs = []
///         if rawdata[i:i+2] == '<>':
///             # SGML shorthand: <> == <last open tag seen>
///             k = j
///             tag = self.lasttag
///         else:
///             match = tagfind.match(rawdata, i+1)
///             if not match:
///                 self.error('unexpected call to parse_starttag')
///             k = match.end(0)
///             tag = rawdata[i+1:k].lower()
///             self.lasttag = tag
///         while k < j:
///             match = attrfind.match(rawdata, k)
///             if not match: break
///             attrname, rest, attrvalue = match.group(1, 2, 3)
///             if not rest:
///                 attrvalue = attrname
///             else:
///                 if (attrvalue[:1] == "'" == attrvalue[-1:] or
///                     attrvalue[:1] == '"' == attrvalue[-1:]):
///                     # strip quotes
///                     attrvalue = attrvalue[1:-1]
///                 attrvalue = self.entity_or_charref.sub(
///                     self._convert_ref, attrvalue)
///             attrs.append((attrname.lower(), attrvalue))
///             k = match.end(0)
///         if rawdata[j] == '>':
///             j = j+1
///         self.__starttag_text = rawdata[start_pos:j]
///         self.finish_starttag(tag, attrs)
///         return j
///
///     # Internal -- convert entity or character reference
///     def _convert_ref(self, match):
///         if match.group(2):
///             return self.convert_charref(match.group(2)) or \
///                 '&#%s%s' % match.groups()[1:]
///         elif match.group(3):
///             return self.convert_entityref(match.group(1)) or \
///                 '&%s;' % match.group(1)
///         else:
///             return '&%s' % match.group(1)
///
///     # Internal -- parse endtag
///     def parse_endtag(self, i):
///         rawdata = self.rawdata
///         match = endbracket.search(rawdata, i+1)
///         if not match:
///             return -1
///         j = match.start(0)
///         tag = rawdata[i+2:j].strip().lower()
///         if rawdata[j] == '>':
///             j = j+1
///         self.finish_endtag(tag)
///         return j
///
///     # Internal -- finish parsing of <tag/data/ (same as <tag>data</tag>)
///     def finish_shorttag(self, tag, data):
///         self.finish_starttag(tag, [])
///         self.handle_data(data)
///         self.finish_endtag(tag)
///
///     # Internal -- finish processing of start tag
///     # Return -1 for unknown tag, 0 for open-only tag, 1 for balanced tag
///     def finish_starttag(self, tag, attrs):
///         try:
///             method = getattr(self, 'start_' + tag)
///         except AttributeError:
///             try:
///                 method = getattr(self, 'do_' + tag)
///             except AttributeError:
///                 self.unknown_starttag(tag, attrs)
///                 return -1
///             else:
///                 self.handle_starttag(tag, method, attrs)
///                 return 0
///         else:
///             self.stack.append(tag)
///             self.handle_starttag(tag, method, attrs)
///             return 1
///
///     # Internal -- finish processing of end tag
///     def finish_endtag(self, tag):
///         if not tag:
///             found = len(self.stack) - 1
///             if found < 0:
///                 self.unknown_endtag(tag)
///                 return
///         else:
///             if tag not in self.stack:
///                 try:
///                     method = getattr(self, 'end_' + tag)
///                 except AttributeError:
///                     self.unknown_endtag(tag)
///                 else:
///                     self.report_unbalanced(tag)
///                 return
///             found = len(self.stack)
///             for i in range(found):
///                 if self.stack[i] == tag: found = i
///         while len(self.stack) > found:
///             tag = self.stack[-1]
///             try:
///                 method = getattr(self, 'end_' + tag)
///             except AttributeError:
///                 method = None
///             if method:
///                 self.handle_endtag(tag, method)
///             else:
///                 self.unknown_endtag(tag)
///             del self.stack[-1]
///
///     # Overridable -- handle start tag
///     def handle_starttag(self, tag, method, attrs):
///         method(attrs)
///
///     # Overridable -- handle end tag
///     def handle_endtag(self, tag, method):
///         method()
///
///     # Example -- report an unbalanced </...> tag.
///     def report_unbalanced(self, tag):
///         if self.verbose:
///             print('*** Unbalanced </' + tag + '>')
///             print('*** Stack:', self.stack)
///
///     def convert_charref(self, name):
///         """Convert character reference, may be overridden."""
///         try:
///             n = int(name)
///         except ValueError:
///             return
///         if not 0 <= n <= 127:
///             return
///         return self.convert_codepoint(n)
///
///     def convert_codepoint(self, codepoint):
///         return chr(codepoint)
///
///     def handle_charref(self, name):
///         """Handle character reference, no need to override."""
///         replacement = self.convert_charref(name)
///         if replacement is None:
///             self.unknown_charref(name)
///         else:
///             self.handle_data(replacement)
///
///     # Definition of entities -- derived classes may override
///     entitydefs = \
///             {'lt': '<', 'gt': '>', 'amp': '&', 'quot': '"', 'apos': '\''}
///
///     def convert_entityref(self, name):
///         """Convert entity references.
///
///         As an alternative to overriding this method; one can tailor the
///         results by setting up the self.entitydefs mapping appropriately.
///         """
///         table = self.entitydefs
///         if name in table:
///             return table[name]
///         else:
///             return
///
///     def handle_entityref(self, name):
///         """Handle entity references, no need to override."""
///         replacement = self.convert_entityref(name)
///         if replacement is None:
///             self.unknown_entityref(name)
///         else:
///             self.handle_data(replacement)
///
///     # Example -- handle data, should be overridden
///     def handle_data(self, data):
///         pass
///
///     # Example -- handle comment, could be overridden
///     def handle_comment(self, data):
///         pass
///
///     # Example -- handle declaration, could be overridden
///     def handle_decl(self, decl):
///         pass
///
///     # Example -- handle processing instruction, could be overridden
///     def handle_pi(self, data):
///         pass
///
///     # To be overridden -- handlers for unknown objects
///     def unknown_starttag(self, tag, attrs): pass
///     def unknown_endtag(self, tag): pass
///     def unknown_charref(self, ref): pass
///     def unknown_entityref(self, ref): pass
///
///
/// class TestSGMLParser(SGMLParser):
///
///     def __init__(self, verbose=0):
///         self.testdata = ""
///         SGMLParser.__init__(self, verbose)
///
///     def handle_data(self, data):
///         self.testdata = self.testdata + data
///         if len(repr(self.testdata)) >= 70:
///             self.flush()
///
///     def flush(self):
///         data = self.testdata
///         if data:
///             self.testdata = ""
///             print('data:', repr(data))
///
///     def handle_comment(self, data):
///         self.flush()
///         r = repr(data)
///         if len(r) > 68:
///             r = r[:32] + '...' + r[-32:]
///         print('comment:', r)
///
///     def unknown_starttag(self, tag, attrs):
///         self.flush()
///         if not attrs:
///             print('start tag: <' + tag + '>')
///         else:
///             print('start tag: <' + tag, end=' ')
///             for name, value in attrs:
///                 print(name + '=' + '"' + value + '"', end=' ')
///             print('>')
///
///     def unknown_endtag(self, tag):
///         self.flush()
///         print('end tag: </' + tag + '>')
///
///     def unknown_entityref(self, ref):
///         self.flush()
///         print('*** unknown entity ref: &' + ref + ';')
///
///     def unknown_charref(self, ref):
///         self.flush()
///         print('*** unknown char ref: &#' + ref + ';')
///
///     def unknown_decl(self, data):
///         self.flush()
///         print('*** unknown decl: [' + data + ']')
///
///     def close(self):
///         SGMLParser.close(self)
///         self.flush()
///
///
/// def test(args = None):
///     import sys
///
///     if args is None:
///         args = sys.argv[1:]
///
///     if args and args[0] == '-s':
///         args = args[1:]
///         klass = SGMLParser
///     else:
///         klass = TestSGMLParser
///
///     if args:
///         file = args[0]
///     else:
///         file = 'test.html'
///
///     if file == '-':
///         f = sys.stdin
///     else:
///         try:
///             f = open(file, 'r')
///         except IOError as msg:
///             print(file, ":", msg)
///             sys.exit(1)
///
///     data = f.read()
///     if f is not sys.stdin:
///         f.close()
///
///     x = klass()
///     for c in data:
///         x.feed(c)
///     x.close()
///
///
/// if __name__ == '__main__':
///     test()
/// ```
final class sgmllib extends PythonModule {
  sgmllib.from(super.pythonModule) : super.from();

  static sgmllib import() => PythonFfiDart.instance.importModule(
        "sgmllib",
        sgmllib.from,
      );

  /// ## test
  ///
  /// ### python source
  /// ```py
  /// def test(args = None):
  ///     import sys
  ///
  ///     if args is None:
  ///         args = sys.argv[1:]
  ///
  ///     if args and args[0] == '-s':
  ///         args = args[1:]
  ///         klass = SGMLParser
  ///     else:
  ///         klass = TestSGMLParser
  ///
  ///     if args:
  ///         file = args[0]
  ///     else:
  ///         file = 'test.html'
  ///
  ///     if file == '-':
  ///         f = sys.stdin
  ///     else:
  ///         try:
  ///             f = open(file, 'r')
  ///         except IOError as msg:
  ///             print(file, ":", msg)
  ///             sys.exit(1)
  ///
  ///     data = f.read()
  ///     if f is not sys.stdin:
  ///         f.close()
  ///
  ///     x = klass()
  ///     for c in data:
  ///         x.feed(c)
  ///     x.close()
  /// ```
  Object? test({
    Object? args,
  }) =>
      getFunction("test").call(
        <Object?>[
          args,
        ],
        kwargs: <String, Object?>{},
      );
}
