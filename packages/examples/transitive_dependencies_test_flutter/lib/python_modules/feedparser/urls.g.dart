// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library urls;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## RelativeURIResolver
///
/// ### python docstring
///
/// Parser base class which provides some common support methods used
/// by the SGML/HTML and XHTML parsers.
///
/// ### python source
/// ```py
/// class RelativeURIResolver(_BaseHTMLProcessor):
///     relative_uris = {
///         ('a', 'href'),
///         ('applet', 'codebase'),
///         ('area', 'href'),
///         ('audio', 'src'),
///         ('blockquote', 'cite'),
///         ('body', 'background'),
///         ('del', 'cite'),
///         ('form', 'action'),
///         ('frame', 'longdesc'),
///         ('frame', 'src'),
///         ('iframe', 'longdesc'),
///         ('iframe', 'src'),
///         ('head', 'profile'),
///         ('img', 'longdesc'),
///         ('img', 'src'),
///         ('img', 'usemap'),
///         ('input', 'src'),
///         ('input', 'usemap'),
///         ('ins', 'cite'),
///         ('link', 'href'),
///         ('object', 'classid'),
///         ('object', 'codebase'),
///         ('object', 'data'),
///         ('object', 'usemap'),
///         ('q', 'cite'),
///         ('script', 'src'),
///         ('source', 'src'),
///         ('video', 'poster'),
///         ('video', 'src'),
///     }
///
///     def __init__(self, baseuri, encoding, _type):
///         _BaseHTMLProcessor.__init__(self, encoding, _type)
///         self.baseuri = baseuri
///
///     def resolve_uri(self, uri):
///         return make_safe_absolute_uri(self.baseuri, uri.strip())
///
///     def unknown_starttag(self, tag, attrs):
///         attrs = self.normalize_attrs(attrs)
///         attrs = [(key, ((tag, key) in self.relative_uris) and self.resolve_uri(value) or value) for key, value in attrs]
///         super(RelativeURIResolver, self).unknown_starttag(tag, attrs)
/// ```
final class RelativeURIResolver extends PythonClass {
  factory RelativeURIResolver({
    required Object? baseuri,
    required Object? encoding,
    required Object? $_type,
  }) =>
      PythonFfiDart.instance.importClass(
        "feedparser.urls",
        "RelativeURIResolver",
        RelativeURIResolver.from,
        <Object?>[
          baseuri,
          encoding,
          $_type,
        ],
        <String, Object?>{},
      );

  RelativeURIResolver.from(super.pythonClass) : super.from();

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
  /// :type name: str
  /// :rtype: str
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def convert_charref(name):
  ///         """
  ///         :type name: str
  ///         :rtype: str
  ///         """
  ///
  ///         return '&#%s;' % name
  /// ```
  Object? convert_charref() => getFunction("convert_charref").call(
        <Object?>[],
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
  /// :type name: str
  /// :rtype: str
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def convert_entityref(name):
  ///         """
  ///         :type name: str
  ///         :rtype: str
  ///         """
  ///
  ///         return '&%s;' % name
  /// ```
  Object? convert_entityref() => getFunction("convert_entityref").call(
        <Object?>[],
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
  /// :type data: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def feed(self, data):
  ///         """
  ///         :type data: str
  ///         :rtype: None
  ///         """
  ///
  ///         data = re.sub(r'<!((?!DOCTYPE|--|\[))', r'&lt;!\1', data, re.IGNORECASE)
  ///         data = re.sub(r'<([^<>\s]+?)\s*/>', self._shorttag_replace, data)
  ///         data = data.replace('&#39;', "'")
  ///         data = data.replace('&#34;', '"')
  ///         super(_BaseHTMLProcessor, self).feed(data)
  ///         super(_BaseHTMLProcessor, self).close()
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
  /// :type ref: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_charref(self, ref):
  ///         """
  ///         :type ref: str
  ///         :rtype: None
  ///         """
  ///
  ///         # Called for each character reference, e.g. '&#160;' will extract '160'
  ///         # Reconstruct the original character reference.
  ///         ref = ref.lower()
  ///         if ref.startswith('x'):
  ///             value = int(ref[1:], 16)
  ///         else:
  ///             value = int(ref)
  ///
  ///         if value in _cp1252:
  ///             self.pieces.append('&#%s;' % hex(ord(_cp1252[value]))[1:])
  ///         else:
  ///             self.pieces.append('&#%s;' % ref)
  /// ```
  Object? handle_charref({
    required Object? ref,
  }) =>
      getFunction("handle_charref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_comment
  ///
  /// ### python docstring
  ///
  /// :type text: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_comment(self, text):
  ///         """
  ///         :type text: str
  ///         :rtype: None
  ///         """
  ///
  ///         # Called for HTML comments, e.g. <!-- insert Javascript code here -->
  ///         # Reconstruct the original comment.
  ///         self.pieces.append('<!--%s-->' % text)
  /// ```
  Object? handle_comment({
    required Object? text,
  }) =>
      getFunction("handle_comment").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_data
  ///
  /// ### python docstring
  ///
  /// :type text: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_data(self, text):
  ///         """
  ///         :type text: str
  ///         :rtype: None
  ///         """
  ///
  ///         # called for each block of plain text, i.e. outside of any tag and
  ///         # not containing any character or entity references
  ///         # Store the original text verbatim.
  ///         self.pieces.append(text)
  /// ```
  Object? handle_data({
    required Object? text,
  }) =>
      getFunction("handle_data").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_decl
  ///
  /// ### python docstring
  ///
  /// :type text: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_decl(self, text):
  ///         """
  ///         :type text: str
  ///         :rtype: None
  ///         """
  ///
  ///         # called for the DOCTYPE, if present, e.g.
  ///         # <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  ///         #     "http://www.w3.org/TR/html4/loose.dtd">
  ///         # Reconstruct original DOCTYPE
  ///         self.pieces.append('<!%s>' % text)
  /// ```
  Object? handle_decl({
    required Object? text,
  }) =>
      getFunction("handle_decl").call(
        <Object?>[
          text,
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
  /// :type ref: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_entityref(self, ref):
  ///         """
  ///         :type ref: str
  ///         :rtype: None
  ///         """
  ///
  ///         # Called for each entity reference, e.g. '&copy;' will extract 'copy'
  ///         # Reconstruct the original entity reference.
  ///         if ref in html.entities.name2codepoint or ref == 'apos':
  ///             self.pieces.append('&%s;' % ref)
  ///         else:
  ///             self.pieces.append('&amp;%s' % ref)
  /// ```
  Object? handle_entityref({
    required Object? ref,
  }) =>
      getFunction("handle_entityref").call(
        <Object?>[
          ref,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_pi
  ///
  /// ### python docstring
  ///
  /// :type text: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def handle_pi(self, text):
  ///         """
  ///         :type text: str
  ///         :rtype: None
  ///         """
  ///
  ///         # Called for each processing instruction, e.g. <?instruction>
  ///         # Reconstruct original processing instruction.
  ///         self.pieces.append('<?%s>' % text)
  /// ```
  Object? handle_pi({
    required Object? text,
  }) =>
      getFunction("handle_pi").call(
        <Object?>[
          text,
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

  /// ## normalize_attrs
  ///
  /// ### python docstring
  ///
  /// :type attrs: List[Tuple[str, str]]
  /// :rtype: List[Tuple[str, str]]
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def normalize_attrs(attrs):
  ///         """
  ///         :type attrs: List[Tuple[str, str]]
  ///         :rtype: List[Tuple[str, str]]
  ///         """
  ///
  ///         if not attrs:
  ///             return attrs
  ///         # utility method to be called by descendants
  ///         # Collapse any duplicate attribute names and values by converting
  ///         # *attrs* into a dictionary, then convert it back to a list.
  ///         attrs_d = {k.lower(): v for k, v in attrs}
  ///         attrs = [
  ///             (k, k in ('rel', 'type') and v.lower() or v)
  ///             for k, v in attrs_d.items()
  ///         ]
  ///         attrs.sort()
  ///         return attrs
  /// ```
  Object? normalize_attrs() => getFunction("normalize_attrs").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## output
  ///
  /// ### python docstring
  ///
  /// Return processed HTML as a single string.
  ///
  /// :rtype: str
  ///
  /// ### python source
  /// ```py
  /// def output(self):
  ///         """Return processed HTML as a single string.
  ///
  ///         :rtype: str
  ///         """
  ///
  ///         return ''.join(self.pieces)
  /// ```
  Object? output() => getFunction("output").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## parse_declaration
  ///
  /// ### python docstring
  ///
  /// :type i: int
  /// :rtype: int
  ///
  /// ### python source
  /// ```py
  /// def parse_declaration(self, i):
  ///         """
  ///         :type i: int
  ///         :rtype: int
  ///         """
  ///
  ///         try:
  ///             return sgmllib.SGMLParser.parse_declaration(self, i)
  ///         except sgmllib.SGMLParseError:
  ///             # Escape the doctype declaration and continue parsing.
  ///             self.handle_data('&lt;')
  ///             return i+1
  /// ```
  Object? parse_declaration({
    required Object? i,
  }) =>
      getFunction("parse_declaration").call(
        <Object?>[
          i,
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
  ///         j = self.__parse_starttag(i)
  ///         if self._type == 'application/xhtml+xml':
  ///             if j > 2 and self.rawdata[j-2:j] == '/>':
  ///                 self.unknown_endtag(self.lasttag)
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
  ///         self.pieces = []
  ///         super(_BaseHTMLProcessor, self).reset()
  /// ```
  Object? reset() => getFunction("reset").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## resolve_uri
  ///
  /// ### python source
  /// ```py
  /// def resolve_uri(self, uri):
  ///         return make_safe_absolute_uri(self.baseuri, uri.strip())
  /// ```
  Object? resolve_uri({
    required Object? uri,
  }) =>
      getFunction("resolve_uri").call(
        <Object?>[
          uri,
        ],
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
  /// ### python docstring
  ///
  /// :type tag: str
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def unknown_endtag(self, tag):
  ///         """
  ///         :type tag: str
  ///         :rtype: None
  ///         """
  ///
  ///         # Called for each end tag, e.g. for </pre>, tag will be 'pre'
  ///         # Reconstruct the original end tag.
  ///         if tag not in self.elements_no_end_tag:
  ///             self.pieces.append("</%s>" % tag)
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
  /// ### python docstring
  ///
  /// :type tag: str
  /// :type attrs: List[Tuple[str, str]]
  /// :rtype: None
  ///
  /// ### python source
  /// ```py
  /// def unknown_starttag(self, tag, attrs):
  ///         attrs = self.normalize_attrs(attrs)
  ///         attrs = [(key, ((tag, key) in self.relative_uris) and self.resolve_uri(value) or value) for key, value in attrs]
  ///         super(RelativeURIResolver, self).unknown_starttag(tag, attrs)
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

  /// ## bare_ampersand (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get bare_ampersand => getAttribute("bare_ampersand");

  /// ## bare_ampersand (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set bare_ampersand(Object? bare_ampersand) =>
      setAttribute("bare_ampersand", bare_ampersand);

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

  /// ## special (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get special => getAttribute("special");

  /// ## special (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set special(Object? special) => setAttribute("special", special);

  /// ## elements_no_end_tag (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get elements_no_end_tag => getAttribute("elements_no_end_tag");

  /// ## elements_no_end_tag (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set elements_no_end_tag(Object? elements_no_end_tag) =>
      setAttribute("elements_no_end_tag", elements_no_end_tag);

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

  /// ## relative_uris (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get relative_uris => getAttribute("relative_uris");

  /// ## relative_uris (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set relative_uris(Object? relative_uris) =>
      setAttribute("relative_uris", relative_uris);

  /// ## baseuri (getter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  Object? get baseuri => getAttribute("baseuri");

  /// ## baseuri (setter)
  ///
  /// ### python docstring
  ///
  /// Parser base class which provides some common support methods used
  /// by the SGML/HTML and XHTML parsers.
  set baseuri(Object? baseuri) => setAttribute("baseuri", baseuri);
}

/// ## urls
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
/// import urllib.parse
///
/// from .html import _BaseHTMLProcessor
///
/// # If you want feedparser to allow all URL schemes, set this to ()
/// # List culled from Python's urlparse documentation at:
/// #   http://docs.python.org/library/urlparse.html
/// # as well as from "URI scheme" at Wikipedia:
/// #   https://secure.wikimedia.org/wikipedia/en/wiki/URI_scheme
/// # Many more will likely need to be added!
/// ACCEPTABLE_URI_SCHEMES = (
///     'file', 'ftp', 'gopher', 'h323', 'hdl', 'http', 'https', 'imap', 'magnet',
///     'mailto', 'mms', 'news', 'nntp', 'prospero', 'rsync', 'rtsp', 'rtspu',
///     'sftp', 'shttp', 'sip', 'sips', 'snews', 'svn', 'svn+ssh', 'telnet',
///     'wais',
///     # Additional common-but-unofficial schemes
///     'aim', 'callto', 'cvs', 'facetime', 'feed', 'git', 'gtalk', 'irc', 'ircs',
///     'irc6', 'itms', 'mms', 'msnim', 'skype', 'ssh', 'smb', 'svn', 'ymsg',
/// )
///
/// _urifixer = re.compile('^([A-Za-z][A-Za-z0-9+-.]*://)(/*)(.*?)')
///
///
/// def _urljoin(base, uri):
///     uri = _urifixer.sub(r'\1\3', uri)
///     try:
///         uri = urllib.parse.urljoin(base, uri)
///     except ValueError:
///         uri = ''
///     return uri
///
///
/// def convert_to_idn(url):
///     """Convert a URL to IDN notation"""
///     # this function should only be called with a unicode string
///     # strategy: if the host cannot be encoded in ascii, then
///     # it'll be necessary to encode it in idn form
///     parts = list(urllib.parse.urlsplit(url))
///     try:
///         parts[1].encode('ascii')
///     except UnicodeEncodeError:
///         # the url needs to be converted to idn notation
///         host = parts[1].rsplit(':', 1)
///         newhost = []
///         port = ''
///         if len(host) == 2:
///             port = host.pop()
///         for h in host[0].split('.'):
///             newhost.append(h.encode('idna').decode('utf-8'))
///         parts[1] = '.'.join(newhost)
///         if port:
///             parts[1] += ':' + port
///         return urllib.parse.urlunsplit(parts)
///     else:
///         return url
///
///
/// def make_safe_absolute_uri(base, rel=None):
///     # bail if ACCEPTABLE_URI_SCHEMES is empty
///     if not ACCEPTABLE_URI_SCHEMES:
///         return _urljoin(base, rel or '')
///     if not base:
///         return rel or ''
///     if not rel:
///         try:
///             scheme = urllib.parse.urlparse(base)[0]
///         except ValueError:
///             return ''
///         if not scheme or scheme in ACCEPTABLE_URI_SCHEMES:
///             return base
///         return ''
///     uri = _urljoin(base, rel)
///     if uri.strip().split(':', 1)[0] not in ACCEPTABLE_URI_SCHEMES:
///         return ''
///     return uri
///
///
/// class RelativeURIResolver(_BaseHTMLProcessor):
///     relative_uris = {
///         ('a', 'href'),
///         ('applet', 'codebase'),
///         ('area', 'href'),
///         ('audio', 'src'),
///         ('blockquote', 'cite'),
///         ('body', 'background'),
///         ('del', 'cite'),
///         ('form', 'action'),
///         ('frame', 'longdesc'),
///         ('frame', 'src'),
///         ('iframe', 'longdesc'),
///         ('iframe', 'src'),
///         ('head', 'profile'),
///         ('img', 'longdesc'),
///         ('img', 'src'),
///         ('img', 'usemap'),
///         ('input', 'src'),
///         ('input', 'usemap'),
///         ('ins', 'cite'),
///         ('link', 'href'),
///         ('object', 'classid'),
///         ('object', 'codebase'),
///         ('object', 'data'),
///         ('object', 'usemap'),
///         ('q', 'cite'),
///         ('script', 'src'),
///         ('source', 'src'),
///         ('video', 'poster'),
///         ('video', 'src'),
///     }
///
///     def __init__(self, baseuri, encoding, _type):
///         _BaseHTMLProcessor.__init__(self, encoding, _type)
///         self.baseuri = baseuri
///
///     def resolve_uri(self, uri):
///         return make_safe_absolute_uri(self.baseuri, uri.strip())
///
///     def unknown_starttag(self, tag, attrs):
///         attrs = self.normalize_attrs(attrs)
///         attrs = [(key, ((tag, key) in self.relative_uris) and self.resolve_uri(value) or value) for key, value in attrs]
///         super(RelativeURIResolver, self).unknown_starttag(tag, attrs)
///
///
/// def resolve_relative_uris(html_source, base_uri, encoding, type_):
///     p = RelativeURIResolver(base_uri, encoding, type_)
///     p.feed(html_source)
///     return p.output()
/// ```
final class urls extends PythonModule {
  urls.from(super.pythonModule) : super.from();

  static urls import() => PythonFfiDart.instance.importModule(
        "feedparser.urls",
        urls.from,
      );

  /// ## convert_to_idn
  ///
  /// ### python docstring
  ///
  /// Convert a URL to IDN notation
  ///
  /// ### python source
  /// ```py
  /// def convert_to_idn(url):
  ///     """Convert a URL to IDN notation"""
  ///     # this function should only be called with a unicode string
  ///     # strategy: if the host cannot be encoded in ascii, then
  ///     # it'll be necessary to encode it in idn form
  ///     parts = list(urllib.parse.urlsplit(url))
  ///     try:
  ///         parts[1].encode('ascii')
  ///     except UnicodeEncodeError:
  ///         # the url needs to be converted to idn notation
  ///         host = parts[1].rsplit(':', 1)
  ///         newhost = []
  ///         port = ''
  ///         if len(host) == 2:
  ///             port = host.pop()
  ///         for h in host[0].split('.'):
  ///             newhost.append(h.encode('idna').decode('utf-8'))
  ///         parts[1] = '.'.join(newhost)
  ///         if port:
  ///             parts[1] += ':' + port
  ///         return urllib.parse.urlunsplit(parts)
  ///     else:
  ///         return url
  /// ```
  Object? convert_to_idn({
    required Object? url,
  }) =>
      getFunction("convert_to_idn").call(
        <Object?>[
          url,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## make_safe_absolute_uri
  ///
  /// ### python source
  /// ```py
  /// def make_safe_absolute_uri(base, rel=None):
  ///     # bail if ACCEPTABLE_URI_SCHEMES is empty
  ///     if not ACCEPTABLE_URI_SCHEMES:
  ///         return _urljoin(base, rel or '')
  ///     if not base:
  ///         return rel or ''
  ///     if not rel:
  ///         try:
  ///             scheme = urllib.parse.urlparse(base)[0]
  ///         except ValueError:
  ///             return ''
  ///         if not scheme or scheme in ACCEPTABLE_URI_SCHEMES:
  ///             return base
  ///         return ''
  ///     uri = _urljoin(base, rel)
  ///     if uri.strip().split(':', 1)[0] not in ACCEPTABLE_URI_SCHEMES:
  ///         return ''
  ///     return uri
  /// ```
  Object? make_safe_absolute_uri({
    required Object? $base,
    Object? rel,
  }) =>
      getFunction("make_safe_absolute_uri").call(
        <Object?>[
          $base,
          rel,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## resolve_relative_uris
  ///
  /// ### python source
  /// ```py
  /// def resolve_relative_uris(html_source, base_uri, encoding, type_):
  ///     p = RelativeURIResolver(base_uri, encoding, type_)
  ///     p.feed(html_source)
  ///     return p.output()
  /// ```
  Object? resolve_relative_uris({
    required Object? html_source,
    required Object? base_uri,
    required Object? encoding,
    required Object? type_,
  }) =>
      getFunction("resolve_relative_uris").call(
        <Object?>[
          html_source,
          base_uri,
          encoding,
          type_,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## ACCEPTABLE_URI_SCHEMES (getter)
  Object? get ACCEPTABLE_URI_SCHEMES => getAttribute("ACCEPTABLE_URI_SCHEMES");

  /// ## ACCEPTABLE_URI_SCHEMES (setter)
  set ACCEPTABLE_URI_SCHEMES(Object? ACCEPTABLE_URI_SCHEMES) =>
      setAttribute("ACCEPTABLE_URI_SCHEMES", ACCEPTABLE_URI_SCHEMES);
}
