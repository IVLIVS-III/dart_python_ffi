// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library api;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## CharacterEncodingOverride
///
/// ### python source
/// ```py
/// class CharacterEncodingOverride(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class CharacterEncodingOverride extends PythonClass {
  factory CharacterEncodingOverride() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "CharacterEncodingOverride",
        CharacterEncodingOverride.from,
        <Object?>[],
      );

  CharacterEncodingOverride.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## CharacterEncodingUnknown
///
/// ### python source
/// ```py
/// class CharacterEncodingUnknown(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class CharacterEncodingUnknown extends PythonClass {
  factory CharacterEncodingUnknown() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "CharacterEncodingUnknown",
        CharacterEncodingUnknown.from,
        <Object?>[],
      );

  CharacterEncodingUnknown.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## FeedParserDict
///
/// ### python source
/// ```py
/// class FeedParserDict(dict):
///     keymap = {
///         'channel': 'feed',
///         'items': 'entries',
///         'guid': 'id',
///         'date': 'updated',
///         'date_parsed': 'updated_parsed',
///         'description': ['summary', 'subtitle'],
///         'description_detail': ['summary_detail', 'subtitle_detail'],
///         'url': ['href'],
///         'modified': 'updated',
///         'modified_parsed': 'updated_parsed',
///         'issued': 'published',
///         'issued_parsed': 'published_parsed',
///         'copyright': 'rights',
///         'copyright_detail': 'rights_detail',
///         'tagline': 'subtitle',
///         'tagline_detail': 'subtitle_detail',
///     }
///
///     def __getitem__(self, key):
///         """
///         :return: A :class:`FeedParserDict`.
///         """
///
///         if key == 'category':
///             try:
///                 return dict.__getitem__(self, 'tags')[0]['term']
///             except IndexError:
///                 raise KeyError("object doesn't have key 'category'")
///         elif key == 'enclosures':
///             norel = lambda link: FeedParserDict([(name, value) for (name, value) in link.items() if name != 'rel'])
///             return [
///                 norel(link)
///                 for link in dict.__getitem__(self, 'links')
///                 if link['rel'] == 'enclosure'
///             ]
///         elif key == 'license':
///             for link in dict.__getitem__(self, 'links'):
///                 if link['rel'] == 'license' and 'href' in link:
///                     return link['href']
///         elif key == 'updated':
///             # Temporarily help developers out by keeping the old
///             # broken behavior that was reported in issue 310.
///             # This fix was proposed in issue 328.
///             if (
///                     not dict.__contains__(self, 'updated')
///                     and dict.__contains__(self, 'published')
///             ):
///                 warnings.warn(
///                     "To avoid breaking existing software while "
///                     "fixing issue 310, a temporary mapping has been created "
///                     "from `updated` to `published` if `updated` doesn't "
///                     "exist. This fallback will be removed in a future version "
///                     "of feedparser.",
///                     DeprecationWarning,
///                 )
///                 return dict.__getitem__(self, 'published')
///             return dict.__getitem__(self, 'updated')
///         elif key == 'updated_parsed':
///             if (
///                     not dict.__contains__(self, 'updated_parsed')
///                     and dict.__contains__(self, 'published_parsed')
///             ):
///                 warnings.warn(
///                     "To avoid breaking existing software while "
///                     "fixing issue 310, a temporary mapping has been created "
///                     "from `updated_parsed` to `published_parsed` if "
///                     "`updated_parsed` doesn't exist. This fallback will be "
///                     "removed in a future version of feedparser.",
///                     DeprecationWarning,
///                 )
///                 return dict.__getitem__(self, 'published_parsed')
///             return dict.__getitem__(self, 'updated_parsed')
///         else:
///             realkey = self.keymap.get(key, key)
///             if isinstance(realkey, list):
///                 for k in realkey:
///                     if dict.__contains__(self, k):
///                         return dict.__getitem__(self, k)
///             elif dict.__contains__(self, realkey):
///                 return dict.__getitem__(self, realkey)
///         return dict.__getitem__(self, key)
///
///     def __contains__(self, key):
///         if key in ('updated', 'updated_parsed'):
///             # Temporarily help developers out by keeping the old
///             # broken behavior that was reported in issue 310.
///             # This fix was proposed in issue 328.
///             return dict.__contains__(self, key)
///         try:
///             self.__getitem__(key)
///         except KeyError:
///             return False
///         else:
///             return True
///
///     has_key = __contains__
///
///     def get(self, key, default=None):
///         """
///         :return: A :class:`FeedParserDict`.
///         """
///
///         try:
///             return self.__getitem__(key)
///         except KeyError:
///             return default
///
///     def __setitem__(self, key, value):
///         key = self.keymap.get(key, key)
///         if isinstance(key, list):
///             key = key[0]
///         return dict.__setitem__(self, key, value)
///
///     def setdefault(self, k, default):
///         if k not in self:
///             self[k] = default
///             return default
///         return self[k]
///
///     def __getattr__(self, key):
///         # __getattribute__() is called first; this will be called
///         # only if an attribute was not already found
///         try:
///             return self.__getitem__(key)
///         except KeyError:
///             raise AttributeError("object has no attribute '%s'" % key)
///
///     def __hash__(self):
///         # This is incorrect behavior -- dictionaries shouldn't be hashable.
///         # Note to self: remove this behavior in the future.
///         return id(self)
/// ```
final class FeedParserDict extends PythonClass {
  factory FeedParserDict() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "FeedParserDict",
        FeedParserDict.from,
        <Object?>[],
      );

  FeedParserDict.from(super.pythonClass) : super.from();

  /// ## get
  ///
  /// ### python docstring
  ///
  /// :return: A :class:`FeedParserDict`.
  ///
  /// ### python source
  /// ```py
  /// def get(self, key, default=None):
  ///         """
  ///         :return: A :class:`FeedParserDict`.
  ///         """
  ///
  ///         try:
  ///             return self.__getitem__(key)
  ///         except KeyError:
  ///             return default
  /// ```
  Object? $get({
    required Object? key,
    Object? $default,
  }) =>
      getFunction("get").call(
        <Object?>[
          key,
          $default,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## has_key
  ///
  /// ### python source
  /// ```py
  /// def __contains__(self, key):
  ///         if key in ('updated', 'updated_parsed'):
  ///             # Temporarily help developers out by keeping the old
  ///             # broken behavior that was reported in issue 310.
  ///             # This fix was proposed in issue 328.
  ///             return dict.__contains__(self, key)
  ///         try:
  ///             self.__getitem__(key)
  ///         except KeyError:
  ///             return False
  ///         else:
  ///             return True
  /// ```
  Object? has_key({
    required Object? key,
  }) =>
      getFunction("has_key").call(
        <Object?>[
          key,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## setdefault
  ///
  /// ### python source
  /// ```py
  /// def setdefault(self, k, default):
  ///         if k not in self:
  ///             self[k] = default
  ///             return default
  ///         return self[k]
  /// ```
  Object? setdefault({
    required Object? k,
    required Object? $default,
  }) =>
      getFunction("setdefault").call(
        <Object?>[
          k,
          $default,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## clear (getter)
  Object? get clear => getAttribute("clear");

  /// ## clear (setter)
  set clear(Object? clear) => setAttribute("clear", clear);

  /// ## copy (getter)
  Object? get copy => getAttribute("copy");

  /// ## copy (setter)
  set copy(Object? copy) => setAttribute("copy", copy);

  /// ## items (getter)
  Object? get items => getAttribute("items");

  /// ## items (setter)
  set items(Object? items) => setAttribute("items", items);

  /// ## keys (getter)
  Object? get keys => getAttribute("keys");

  /// ## keys (setter)
  set keys(Object? keys) => setAttribute("keys", keys);

  /// ## pop (getter)
  Object? get pop => getAttribute("pop");

  /// ## pop (setter)
  set pop(Object? pop) => setAttribute("pop", pop);

  /// ## popitem (getter)
  Object? get popitem => getAttribute("popitem");

  /// ## popitem (setter)
  set popitem(Object? popitem) => setAttribute("popitem", popitem);

  /// ## update (getter)
  Object? get update => getAttribute("update");

  /// ## update (setter)
  set update(Object? update) => setAttribute("update", update);

  /// ## values (getter)
  Object? get values => getAttribute("values");

  /// ## values (setter)
  set values(Object? values) => setAttribute("values", values);

  /// ## keymap (getter)
  Object? get keymap => getAttribute("keymap");

  /// ## keymap (setter)
  set keymap(Object? keymap) => setAttribute("keymap", keymap);
}

/// ## LooseFeedParser
///
/// ### python docstring
///
/// Support for the Atom, RSS, RDF, and CDF feed formats.
///
/// The feed formats all share common elements, some of which have conflicting
/// interpretations. For simplicity, all of the base feed format support is
/// collected here.
final class LooseFeedParser extends PythonClass {
  factory LooseFeedParser({
    Object? baseuri,
    Object? baselang,
    Object? encoding,
    Object? entities,
  }) =>
      PythonFfiDart.instance.importClass(
        "feedparser.api",
        "LooseFeedParser",
        LooseFeedParser.from,
        <Object?>[
          baseuri,
          baselang,
          encoding,
          entities,
        ],
        <String, Object?>{},
      );

  LooseFeedParser.from(super.pythonClass) : super.from();

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

  /// ## decode_entities
  ///
  /// ### python source
  /// ```py
  /// def decode_entities(self, element, data):
  ///         data = data.replace('&#60;', '&lt;')
  ///         data = data.replace('&#x3c;', '&lt;')
  ///         data = data.replace('&#x3C;', '&lt;')
  ///         data = data.replace('&#62;', '&gt;')
  ///         data = data.replace('&#x3e;', '&gt;')
  ///         data = data.replace('&#x3E;', '&gt;')
  ///         data = data.replace('&#38;', '&amp;')
  ///         data = data.replace('&#x26;', '&amp;')
  ///         data = data.replace('&#34;', '&quot;')
  ///         data = data.replace('&#x22;', '&quot;')
  ///         data = data.replace('&#39;', '&apos;')
  ///         data = data.replace('&#x27;', '&apos;')
  ///         if not self.contentparams.get('type', 'xml').endswith('xml'):
  ///             data = data.replace('&lt;', '<')
  ///             data = data.replace('&gt;', '>')
  ///             data = data.replace('&amp;', '&')
  ///             data = data.replace('&quot;', '"')
  ///             data = data.replace('&apos;', "'")
  ///             data = data.replace('&#x2f;', '/')
  ///             data = data.replace('&#x2F;', '/')
  ///         return data
  /// ```
  Object? decode_entities({
    required Object? element,
    required Object? data,
  }) =>
      getFunction("decode_entities").call(
        <Object?>[
          element,
          data,
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
  /// ### python source
  /// ```py
  /// def handle_charref(self, ref):
  ///         # Called for each character reference, e.g. for '&#160;', ref is '160'
  ///         if not self.elementstack:
  ///             return
  ///         ref = ref.lower()
  ///         if ref in ('34', '38', '39', '60', '62', 'x22', 'x26', 'x27', 'x3c', 'x3e'):
  ///             text = '&#%s;' % ref
  ///         else:
  ///             if ref[0] == 'x':
  ///                 c = int(ref[1:], 16)
  ///             else:
  ///                 c = int(ref)
  ///             text = chr(c).encode('utf-8')
  ///         self.elementstack[-1][2].append(text)
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
  /// ### python source
  /// ```py
  /// def handle_comment(self, text):
  ///         # Called for each comment, e.g. <!-- insert message here -->
  ///         pass
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
  /// ### python source
  /// ```py
  /// def handle_data(self, text, escape=1):
  ///         # Called for each block of plain text, i.e. outside of any tag and
  ///         # not containing any character or entity references
  ///         if not self.elementstack:
  ///             return
  ///         if escape and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             text = xml.sax.saxutils.escape(text)
  ///         self.elementstack[-1][2].append(text)
  /// ```
  Object? handle_data({
    required Object? text,
    Object? escape = 1,
  }) =>
      getFunction("handle_data").call(
        <Object?>[
          text,
          escape,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_decl
  ///
  /// ### python source
  /// ```py
  /// def handle_decl(self, text):
  ///         pass
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
  /// ### python source
  /// ```py
  /// def handle_entityref(self, ref):
  ///         # Called for each entity reference, e.g. for '&copy;', ref is 'copy'
  ///         if not self.elementstack:
  ///             return
  ///         if ref in ('lt', 'gt', 'quot', 'amp', 'apos'):
  ///             text = '&%s;' % ref
  ///         elif ref in self.entities:
  ///             text = self.entities[ref]
  ///             if text.startswith('&#') and text.endswith(';'):
  ///                 return self.handle_entityref(text)
  ///         else:
  ///             try:
  ///                 html.entities.name2codepoint[ref]
  ///             except KeyError:
  ///                 text = '&%s;' % ref
  ///             else:
  ///                 text = chr(html.entities.name2codepoint[ref]).encode('utf-8')
  ///         self.elementstack[-1][2].append(text)
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
  /// ### python source
  /// ```py
  /// def handle_pi(self, text):
  ///         # Called for each processing instruction, e.g. <?instruction>
  ///         pass
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

  /// ## looks_like_html
  ///
  /// ### python docstring
  ///
  /// :type s: str
  /// :rtype: bool
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def looks_like_html(s):
  ///         """
  ///         :type s: str
  ///         :rtype: bool
  ///         """
  ///
  ///         # must have a close tag or an entity reference to qualify
  ///         if not (re.search(r'</(\w+)>', s) or re.search(r'&#?\w+;', s)):
  ///             return False
  ///
  ///         # all tags must be in a restricted subset of valid HTML tags
  ///         if any((t for t in re.findall(r'</?(\w+)', s) if t.lower() not in _HTMLSanitizer.acceptable_elements)):
  ///             return False
  ///
  ///         # all entities must have been defined as valid HTML entities
  ///         if any((e for e in re.findall(r'&(\w+);', s) if e not in html.entities.entitydefs)):
  ///             return False
  ///
  ///         return True
  /// ```
  Object? looks_like_html() => getFunction("looks_like_html").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## map_content_type
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def map_content_type(content_type):
  ///         content_type = content_type.lower()
  ///         if content_type == 'text' or content_type == 'plain':
  ///             content_type = 'text/plain'
  ///         elif content_type == 'html':
  ///             content_type = 'text/html'
  ///         elif content_type == 'xhtml':
  ///             content_type = 'application/xhtml+xml'
  ///         return content_type
  /// ```
  Object? map_content_type() => getFunction("map_content_type").call(
        <Object?>[],
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
  /// ### python source
  /// ```py
  /// def parse_declaration(self, i):
  ///         # Override internal declaration handler to handle CDATA blocks.
  ///         if self.rawdata[i:i+9] == '<![CDATA[':
  ///             k = self.rawdata.find(']]>', i)
  ///             if k == -1:
  ///                 # CDATA block began but didn't finish
  ///                 k = len(self.rawdata)
  ///                 return k
  ///             self.handle_data(xml.sax.saxutils.escape(self.rawdata[i+9:k]), 0)
  ///             return k+3
  ///         else:
  ///             k = self.rawdata.find('>', i)
  ///             if k >= 0:
  ///                 return k+1
  ///             else:
  ///                 # We have an incomplete CDATA block.
  ///                 return k
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

  /// ## pop
  ///
  /// ### python source
  /// ```py
  /// def pop(self, element, strip_whitespace=1):
  ///         if not self.elementstack:
  ///             return
  ///         if self.elementstack[-1][0] != element:
  ///             return
  ///
  ///         element, expecting_text, pieces = self.elementstack.pop()
  ///
  ///         # Ensure each piece is a str for Python 3
  ///         for (i, v) in enumerate(pieces):
  ///             if isinstance(v, bytes):
  ///                 pieces[i] = v.decode('utf-8')
  ///
  ///         if self.version == 'atom10' and self.contentparams.get('type', 'text') == 'application/xhtml+xml':
  ///             # remove enclosing child element, but only if it is a <div> and
  ///             # only if all the remaining content is nested underneath it.
  ///             # This means that the divs would be retained in the following:
  ///             #    <div>foo</div><div>bar</div>
  ///             while pieces and len(pieces) > 1 and not pieces[-1].strip():
  ///                 del pieces[-1]
  ///             while pieces and len(pieces) > 1 and not pieces[0].strip():
  ///                 del pieces[0]
  ///             if pieces and (pieces[0] == '<div>' or pieces[0].startswith('<div ')) and pieces[-1] == '</div>':
  ///                 depth = 0
  ///                 for piece in pieces[:-1]:
  ///                     if piece.startswith('</'):
  ///                         depth -= 1
  ///                         if depth == 0:
  ///                             break
  ///                     elif piece.startswith('<') and not piece.endswith('/>'):
  ///                         depth += 1
  ///                 else:
  ///                     pieces = pieces[1:-1]
  ///
  ///         output = ''.join(pieces)
  ///         if strip_whitespace:
  ///             output = output.strip()
  ///         if not expecting_text:
  ///             return output
  ///
  ///         # decode base64 content
  ///         if base64 and self.contentparams.get('base64', 0):
  ///             try:
  ///                 output = base64.decodebytes(output.encode('utf8')).decode('utf8')
  ///             except (binascii.Error, binascii.Incomplete, UnicodeDecodeError):
  ///                 pass
  ///
  ///         # resolve relative URIs
  ///         if (element in self.can_be_relative_uri) and output:
  ///             # do not resolve guid elements with isPermalink="false"
  ///             if not element == 'id' or self.guidislink:
  ///                 output = self.resolve_uri(output)
  ///
  ///         # decode entities within embedded markup
  ///         if not self.contentparams.get('base64', 0):
  ///             output = self.decode_entities(element, output)
  ///
  ///         # some feed formats require consumers to guess
  ///         # whether the content is html or plain text
  ///         if not self.version.startswith('atom') and self.contentparams.get('type') == 'text/plain':
  ///             if self.looks_like_html(output):
  ///                 self.contentparams['type'] = 'text/html'
  ///
  ///         # remove temporary cruft from contentparams
  ///         try:
  ///             del self.contentparams['mode']
  ///         except KeyError:
  ///             pass
  ///         try:
  ///             del self.contentparams['base64']
  ///         except KeyError:
  ///             pass
  ///
  ///         is_htmlish = self.map_content_type(self.contentparams.get('type', 'text/html')) in self.html_types
  ///         # resolve relative URIs within embedded markup
  ///         if is_htmlish and self.resolve_relative_uris:
  ///             if element in self.can_contain_relative_uris:
  ///                 output = resolve_relative_uris(output, self.baseuri, self.encoding, self.contentparams.get('type', 'text/html'))
  ///
  ///         # sanitize embedded markup
  ///         if is_htmlish and self.sanitize_html:
  ///             if element in self.can_contain_dangerous_markup:
  ///                 output = _sanitize_html(output, self.encoding, self.contentparams.get('type', 'text/html'))
  ///
  ///         if self.encoding and isinstance(output, bytes):
  ///             output = output.decode(self.encoding, 'ignore')
  ///
  ///         # address common error where people take data that is already
  ///         # utf-8, presume that it is iso-8859-1, and re-encode it.
  ///         if self.encoding in ('utf-8', 'utf-8_INVALID_PYTHON_3') and not isinstance(output, bytes):
  ///             try:
  ///                 output = output.encode('iso-8859-1').decode('utf-8')
  ///             except (UnicodeEncodeError, UnicodeDecodeError):
  ///                 pass
  ///
  ///         # map win-1252 extensions to the proper code points
  ///         if not isinstance(output, bytes):
  ///             output = output.translate(_cp1252)
  ///
  ///         # categories/tags/keywords/whatever are handled in _end_category or
  ///         # _end_tags or _end_itunes_keywords
  ///         if element in ('category', 'tags', 'itunes_keywords'):
  ///             return output
  ///
  ///         if element == 'title' and -1 < self.title_depth <= self.depth:
  ///             return output
  ///
  ///         # store output in appropriate place(s)
  ///         if self.inentry and not self.insource:
  ///             if element == 'content':
  ///                 self.entries[-1].setdefault(element, [])
  ///                 contentparams = copy.deepcopy(self.contentparams)
  ///                 contentparams['value'] = output
  ///                 self.entries[-1][element].append(contentparams)
  ///             elif element == 'link':
  ///                 if not self.inimage:
  ///                     # query variables in urls in link elements are improperly
  ///                     # converted from `?a=1&b=2` to `?a=1&b;=2` as if they're
  ///                     # unhandled character references. fix this special case.
  ///                     output = output.replace('&amp;', '&')
  ///                     output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
  ///                     self.entries[-1][element] = output
  ///                     if output:
  ///                         self.entries[-1]['links'][-1]['href'] = output
  ///             else:
  ///                 if element == 'description':
  ///                     element = 'summary'
  ///                 old_value_depth = self.property_depth_map.setdefault(self.entries[-1], {}).get(element)
  ///                 if old_value_depth is None or self.depth <= old_value_depth:
  ///                     self.property_depth_map[self.entries[-1]][element] = self.depth
  ///                     self.entries[-1][element] = output
  ///                 if self.incontent:
  ///                     contentparams = copy.deepcopy(self.contentparams)
  ///                     contentparams['value'] = output
  ///                     self.entries[-1][element + '_detail'] = contentparams
  ///         elif self.infeed or self.insource:  # and (not self.intextinput) and (not self.inimage):
  ///             context = self._get_context()
  ///             if element == 'description':
  ///                 element = 'subtitle'
  ///             context[element] = output
  ///             if element == 'link':
  ///                 # fix query variables; see above for the explanation
  ///                 output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
  ///                 context[element] = output
  ///                 context['links'][-1]['href'] = output
  ///             elif self.incontent:
  ///                 contentparams = copy.deepcopy(self.contentparams)
  ///                 contentparams['value'] = output
  ///                 context[element + '_detail'] = contentparams
  ///         return output
  /// ```
  Object? pop({
    required Object? element,
    Object? strip_whitespace = 1,
  }) =>
      getFunction("pop").call(
        <Object?>[
          element,
          strip_whitespace,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pop_content
  ///
  /// ### python source
  /// ```py
  /// def pop_content(self, tag):
  ///         value = self.pop(tag)
  ///         self.incontent -= 1
  ///         self.contentparams.clear()
  ///         return value
  /// ```
  Object? pop_content({
    required Object? tag,
  }) =>
      getFunction("pop_content").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## push
  ///
  /// ### python source
  /// ```py
  /// def push(self, element, expecting_text):
  ///         self.elementstack.append([element, expecting_text, []])
  /// ```
  Object? push({
    required Object? element,
    required Object? expecting_text,
  }) =>
      getFunction("push").call(
        <Object?>[
          element,
          expecting_text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## push_content
  ///
  /// ### python source
  /// ```py
  /// def push_content(self, tag, attrs_d, default_content_type, expecting_text):
  ///         self.incontent += 1
  ///         if self.lang:
  ///             self.lang = self.lang.replace('_', '-')
  ///         self.contentparams = FeedParserDict({
  ///             'type': self.map_content_type(attrs_d.get('type', default_content_type)),
  ///             'language': self.lang,
  ///             'base': self.baseuri})
  ///         self.contentparams['base64'] = self._is_base64(attrs_d, self.contentparams)
  ///         self.push(tag, expecting_text)
  /// ```
  Object? push_content({
    required Object? tag,
    required Object? attrs_d,
    required Object? default_content_type,
    required Object? expecting_text,
  }) =>
      getFunction("push_content").call(
        <Object?>[
          tag,
          attrs_d,
          default_content_type,
          expecting_text,
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
  ///         return _urljoin(self.baseuri or '', uri)
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

  /// ## strattrs
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def strattrs(attrs):
  ///         return ''.join(
  ///             ' %s="%s"' % (n, v.replace('"', '&quot;'))
  ///             for n, v in attrs
  ///         )
  /// ```
  Object? strattrs() => getFunction("strattrs").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## track_namespace
  ///
  /// ### python source
  /// ```py
  /// def track_namespace(self, prefix, uri):
  ///         loweruri = uri.lower()
  ///         if not self.version:
  ///             if (prefix, loweruri) == (None, 'http://my.netscape.com/rdf/simple/0.9/'):
  ///                 self.version = 'rss090'
  ///             elif loweruri == 'http://purl.org/rss/1.0/':
  ///                 self.version = 'rss10'
  ///             elif loweruri == 'http://www.w3.org/2005/atom':
  ///                 self.version = 'atom10'
  ///         if loweruri.find('backend.userland.com/rss') != -1:
  ///             # match any backend.userland.com namespace
  ///             uri = 'http://backend.userland.com/rss'
  ///             loweruri = uri
  ///         if loweruri in self._matchnamespaces:
  ///             self.namespacemap[prefix] = self._matchnamespaces[loweruri]
  ///             self.namespaces_in_use[self._matchnamespaces[loweruri]] = uri
  ///         else:
  ///             self.namespaces_in_use[prefix or ''] = uri
  /// ```
  Object? track_namespace({
    required Object? prefix,
    required Object? uri,
  }) =>
      getFunction("track_namespace").call(
        <Object?>[
          prefix,
          uri,
        ],
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
  /// def unknown_endtag(self, tag):
  ///         # match namespaces
  ///         if tag.find(':') != -1:
  ///             prefix, suffix = tag.split(':', 1)
  ///         else:
  ///             prefix, suffix = '', tag
  ///         prefix = self.namespacemap.get(prefix, prefix)
  ///         if prefix:
  ///             prefix = prefix + '_'
  ///         if suffix == 'svg' and self.svgOK:
  ///             self.svgOK -= 1
  ///
  ///         # call special handler (if defined) or default handler
  ///         methodname = '_end_' + prefix + suffix
  ///         try:
  ///             if self.svgOK:
  ///                 raise AttributeError()
  ///             method = getattr(self, methodname)
  ///             method()
  ///         except AttributeError:
  ///             self.pop(prefix + suffix)
  ///
  ///         # track inline content
  ///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
  ///             # element declared itself as escaped markup, but it isn't really
  ///             if tag in ('xhtml:div', 'div'):
  ///                 return  # typepad does this 10/2007
  ///             self.contentparams['type'] = 'application/xhtml+xml'
  ///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             tag = tag.split(':')[-1]
  ///             self.handle_data('</%s>' % tag, escape=0)
  ///
  ///         # track xml:base and xml:lang going out of scope
  ///         if self.basestack:
  ///             self.basestack.pop()
  ///             if self.basestack and self.basestack[-1]:
  ///                 self.baseuri = self.basestack[-1]
  ///         if self.langstack:
  ///             self.langstack.pop()
  ///             if self.langstack:  # and (self.langstack[-1] is not None):
  ///                 self.lang = self.langstack[-1]
  ///
  ///         self.depth -= 1
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
  /// def unknown_starttag(self, tag, attrs):
  ///         # increment depth counter
  ///         self.depth += 1
  ///
  ///         # normalize attrs
  ///         attrs = [self._normalize_attributes(attr) for attr in attrs]
  ///
  ///         # track xml:base and xml:lang
  ///         attrs_d = dict(attrs)
  ///         baseuri = attrs_d.get('xml:base', attrs_d.get('base')) or self.baseuri
  ///         if isinstance(baseuri, bytes):
  ///             baseuri = baseuri.decode(self.encoding, 'ignore')
  ///         # ensure that self.baseuri is always an absolute URI that
  ///         # uses a whitelisted URI scheme (e.g. not `javscript:`)
  ///         if self.baseuri:
  ///             self.baseuri = make_safe_absolute_uri(self.baseuri, baseuri) or self.baseuri
  ///         else:
  ///             self.baseuri = _urljoin(self.baseuri, baseuri)
  ///         lang = attrs_d.get('xml:lang', attrs_d.get('lang'))
  ///         if lang == '':
  ///             # xml:lang could be explicitly set to '', we need to capture that
  ///             lang = None
  ///         elif lang is None:
  ///             # if no xml:lang is specified, use parent lang
  ///             lang = self.lang
  ///         if lang:
  ///             if tag in ('feed', 'rss', 'rdf:RDF'):
  ///                 self.feeddata['language'] = lang.replace('_', '-')
  ///         self.lang = lang
  ///         self.basestack.append(self.baseuri)
  ///         self.langstack.append(lang)
  ///
  ///         # track namespaces
  ///         for prefix, uri in attrs:
  ///             if prefix.startswith('xmlns:'):
  ///                 self.track_namespace(prefix[6:], uri)
  ///             elif prefix == 'xmlns':
  ///                 self.track_namespace(None, uri)
  ///
  ///         # track inline content
  ///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
  ///             if tag in ('xhtml:div', 'div'):
  ///                 return  # typepad does this 10/2007
  ///             # element declared itself as escaped markup, but it isn't really
  ///             self.contentparams['type'] = 'application/xhtml+xml'
  ///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             if tag.find(':') != -1:
  ///                 prefix, tag = tag.split(':', 1)
  ///                 namespace = self.namespaces_in_use.get(prefix, '')
  ///                 if tag == 'math' and namespace == 'http://www.w3.org/1998/Math/MathML':
  ///                     attrs.append(('xmlns', namespace))
  ///                 if tag == 'svg' and namespace == 'http://www.w3.org/2000/svg':
  ///                     attrs.append(('xmlns', namespace))
  ///             if tag == 'svg':
  ///                 self.svgOK += 1
  ///             return self.handle_data('<%s%s>' % (tag, self.strattrs(attrs)), escape=0)
  ///
  ///         # match namespaces
  ///         if tag.find(':') != -1:
  ///             prefix, suffix = tag.split(':', 1)
  ///         else:
  ///             prefix, suffix = '', tag
  ///         prefix = self.namespacemap.get(prefix, prefix)
  ///         if prefix:
  ///             prefix = prefix + '_'
  ///
  ///         # Special hack for better tracking of empty textinput/image elements in
  ///         # illformed feeds.
  ///         if (not prefix) and tag not in ('title', 'link', 'description', 'name'):
  ///             self.intextinput = 0
  ///         if (not prefix) and tag not in ('title', 'link', 'description', 'url', 'href', 'width', 'height'):
  ///             self.inimage = 0
  ///
  ///         # call special handler (if defined) or default handler
  ///         methodname = '_start_' + prefix + suffix
  ///         try:
  ///             method = getattr(self, methodname)
  ///             return method(attrs_d)
  ///         except AttributeError:
  ///             # Since there's no handler or something has gone wrong we
  ///             # explicitly add the element and its attributes.
  ///             unknown_tag = prefix + suffix
  ///             if len(attrs_d) == 0:
  ///                 # No attributes so merge it into the enclosing dictionary
  ///                 return self.push(unknown_tag, 1)
  ///             else:
  ///                 # Has attributes so create it in its own dictionary
  ///                 context = self._get_context()
  ///                 context[unknown_tag] = attrs_d
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
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get bare_ampersand => getAttribute("bare_ampersand");

  /// ## bare_ampersand (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set bare_ampersand(Object? bare_ampersand) =>
      setAttribute("bare_ampersand", bare_ampersand);

  /// ## entity_or_charref (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get entity_or_charref => getAttribute("entity_or_charref");

  /// ## entity_or_charref (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set entity_or_charref(Object? entity_or_charref) =>
      setAttribute("entity_or_charref", entity_or_charref);

  /// ## special (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get special => getAttribute("special");

  /// ## special (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set special(Object? special) => setAttribute("special", special);

  /// ## can_be_relative_uri (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_be_relative_uri => getAttribute("can_be_relative_uri");

  /// ## can_be_relative_uri (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_be_relative_uri(Object? can_be_relative_uri) =>
      setAttribute("can_be_relative_uri", can_be_relative_uri);

  /// ## can_contain_dangerous_markup (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_contain_dangerous_markup =>
      getAttribute("can_contain_dangerous_markup");

  /// ## can_contain_dangerous_markup (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_contain_dangerous_markup(Object? can_contain_dangerous_markup) =>
      setAttribute(
          "can_contain_dangerous_markup", can_contain_dangerous_markup);

  /// ## can_contain_relative_uris (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_contain_relative_uris =>
      getAttribute("can_contain_relative_uris");

  /// ## can_contain_relative_uris (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_contain_relative_uris(Object? can_contain_relative_uris) =>
      setAttribute("can_contain_relative_uris", can_contain_relative_uris);

  /// ## contentparams (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Null get contentparams => getAttribute("contentparams");

  /// ## contentparams (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set contentparams(Null contentparams) =>
      setAttribute("contentparams", contentparams);

  /// ## elements_no_end_tag (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get elements_no_end_tag => getAttribute("elements_no_end_tag");

  /// ## elements_no_end_tag (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set elements_no_end_tag(Object? elements_no_end_tag) =>
      setAttribute("elements_no_end_tag", elements_no_end_tag);

  /// ## entitydefs (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get entitydefs => getAttribute("entitydefs");

  /// ## entitydefs (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set entitydefs(Object? entitydefs) => setAttribute("entitydefs", entitydefs);

  /// ## html_types (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get html_types => getAttribute("html_types");

  /// ## html_types (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set html_types(Object? html_types) => setAttribute("html_types", html_types);

  /// ## namespaces (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get namespaces => getAttribute("namespaces");

  /// ## namespaces (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set namespaces(Object? namespaces) => setAttribute("namespaces", namespaces);

  /// ## supported_namespaces (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get supported_namespaces => getAttribute("supported_namespaces");

  /// ## supported_namespaces (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set supported_namespaces(Object? supported_namespaces) =>
      setAttribute("supported_namespaces", supported_namespaces);

  /// ## baseuri (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get baseuri => getAttribute("baseuri");

  /// ## baseuri (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set baseuri(Object? baseuri) => setAttribute("baseuri", baseuri);

  /// ## lang (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get lang => getAttribute("lang");

  /// ## lang (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set lang(Object? lang) => setAttribute("lang", lang);

  /// ## encoding (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get encoding => getAttribute("encoding");

  /// ## encoding (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set encoding(Object? encoding) => setAttribute("encoding", encoding);

  /// ## entities (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get entities => getAttribute("entities");

  /// ## entities (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set entities(Object? entities) => setAttribute("entities", entities);
}

/// ## NonXMLContentType
///
/// ### python source
/// ```py
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class NonXMLContentType extends PythonClass {
  factory NonXMLContentType() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "NonXMLContentType",
        NonXMLContentType.from,
        <Object?>[],
      );

  NonXMLContentType.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## StrictFeedParser
///
/// ### python docstring
///
/// Support for the Atom, RSS, RDF, and CDF feed formats.
///
/// The feed formats all share common elements, some of which have conflicting
/// interpretations. For simplicity, all of the base feed format support is
/// collected here.
final class StrictFeedParser extends PythonClass {
  factory StrictFeedParser({
    required Object? baseuri,
    required Object? baselang,
    required Object? encoding,
  }) =>
      PythonFfiDart.instance.importClass(
        "feedparser.api",
        "StrictFeedParser",
        StrictFeedParser.from,
        <Object?>[
          baseuri,
          baselang,
          encoding,
        ],
        <String, Object?>{},
      );

  StrictFeedParser.from(super.pythonClass) : super.from();

  /// ## characters
  ///
  /// ### python source
  /// ```py
  /// def characters(self, text):
  ///         self.handle_data(text)
  /// ```
  Object? characters({
    required Object? text,
  }) =>
      getFunction("characters").call(
        <Object?>[
          text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## decode_entities
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def decode_entities(element, data):
  ///         return data
  /// ```
  Object? decode_entities({
    required Object? data,
  }) =>
      getFunction("decode_entities").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## endElementNS
  ///
  /// ### python source
  /// ```py
  /// def endElementNS(self, name, qname):
  ///         namespace, localname = name
  ///         lowernamespace = str(namespace or '').lower()
  ///         if qname and qname.find(':') > 0:
  ///             givenprefix = qname.split(':')[0]
  ///         else:
  ///             givenprefix = ''
  ///         prefix = self._matchnamespaces.get(lowernamespace, givenprefix)
  ///         if prefix:
  ///             localname = prefix + ':' + localname
  ///         elif namespace and not qname:  # Expat
  ///             for name, value in self.namespaces_in_use.items():
  ///                 if name and value == namespace:
  ///                     localname = name + ':' + localname
  ///                     break
  ///         localname = str(localname).lower()
  ///         self.unknown_endtag(localname)
  /// ```
  Object? endElementNS({
    required Object? name,
    required Object? qname,
  }) =>
      getFunction("endElementNS").call(
        <Object?>[
          name,
          qname,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## error
  ///
  /// ### python source
  /// ```py
  /// def error(self, exc):
  ///         self.bozo = 1
  ///         self.exc = exc
  /// ```
  Object? error({
    required Object? exc,
  }) =>
      getFunction("error").call(
        <Object?>[
          exc,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## fatalError
  ///
  /// ### python source
  /// ```py
  /// def fatalError(self, exc):
  ///         self.error(exc)
  ///         raise exc
  /// ```
  Object? fatalError({
    required Object? exc,
  }) =>
      getFunction("fatalError").call(
        <Object?>[
          exc,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_charref
  ///
  /// ### python source
  /// ```py
  /// def handle_charref(self, ref):
  ///         # Called for each character reference, e.g. for '&#160;', ref is '160'
  ///         if not self.elementstack:
  ///             return
  ///         ref = ref.lower()
  ///         if ref in ('34', '38', '39', '60', '62', 'x22', 'x26', 'x27', 'x3c', 'x3e'):
  ///             text = '&#%s;' % ref
  ///         else:
  ///             if ref[0] == 'x':
  ///                 c = int(ref[1:], 16)
  ///             else:
  ///                 c = int(ref)
  ///             text = chr(c).encode('utf-8')
  ///         self.elementstack[-1][2].append(text)#
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
  /// ### python source
  /// ```py
  /// def handle_comment(self, text):
  ///         # Called for each comment, e.g. <!-- insert message here -->
  ///         pass
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
  /// ### python source
  /// ```py
  /// def handle_data(self, text, escape=1):
  ///         # Called for each block of plain text, i.e. outside of any tag and
  ///         # not containing any character or entity references
  ///         if not self.elementstack:
  ///             return
  ///         if escape and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             text = xml.sax.saxutils.escape(text)
  ///         self.elementstack[-1][2].append(text)
  /// ```
  Object? handle_data({
    required Object? text,
    Object? escape = 1,
  }) =>
      getFunction("handle_data").call(
        <Object?>[
          text,
          escape,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## handle_decl
  ///
  /// ### python source
  /// ```py
  /// def handle_decl(self, text):
  ///         pass
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

  /// ## handle_entityref
  ///
  /// ### python source
  /// ```py
  /// def handle_entityref(self, ref):
  ///         # Called for each entity reference, e.g. for '&copy;', ref is 'copy'
  ///         if not self.elementstack:
  ///             return
  ///         if ref in ('lt', 'gt', 'quot', 'amp', 'apos'):
  ///             text = '&%s;' % ref
  ///         elif ref in self.entities:
  ///             text = self.entities[ref]
  ///             if text.startswith('&#') and text.endswith(';'):
  ///                 return self.handle_entityref(text)
  ///         else:
  ///             try:
  ///                 html.entities.name2codepoint[ref]
  ///             except KeyError:
  ///                 text = '&%s;' % ref
  ///             else:
  ///                 text = chr(html.entities.name2codepoint[ref]).encode('utf-8')
  ///         self.elementstack[-1][2].append(text)
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
  /// ### python source
  /// ```py
  /// def handle_pi(self, text):
  ///         # Called for each processing instruction, e.g. <?instruction>
  ///         pass
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

  /// ## looks_like_html
  ///
  /// ### python docstring
  ///
  /// :type s: str
  /// :rtype: bool
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def looks_like_html(s):
  ///         """
  ///         :type s: str
  ///         :rtype: bool
  ///         """
  ///
  ///         # must have a close tag or an entity reference to qualify
  ///         if not (re.search(r'</(\w+)>', s) or re.search(r'&#?\w+;', s)):
  ///             return False
  ///
  ///         # all tags must be in a restricted subset of valid HTML tags
  ///         if any((t for t in re.findall(r'</?(\w+)', s) if t.lower() not in _HTMLSanitizer.acceptable_elements)):
  ///             return False
  ///
  ///         # all entities must have been defined as valid HTML entities
  ///         if any((e for e in re.findall(r'&(\w+);', s) if e not in html.entities.entitydefs)):
  ///             return False
  ///
  ///         return True
  /// ```
  Object? looks_like_html() => getFunction("looks_like_html").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## map_content_type
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def map_content_type(content_type):
  ///         content_type = content_type.lower()
  ///         if content_type == 'text' or content_type == 'plain':
  ///             content_type = 'text/plain'
  ///         elif content_type == 'html':
  ///             content_type = 'text/html'
  ///         elif content_type == 'xhtml':
  ///             content_type = 'application/xhtml+xml'
  ///         return content_type
  /// ```
  Object? map_content_type() => getFunction("map_content_type").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## parse_declaration
  ///
  /// ### python source
  /// ```py
  /// def parse_declaration(self, i):
  ///         # Override internal declaration handler to handle CDATA blocks.
  ///         if self.rawdata[i:i+9] == '<![CDATA[':
  ///             k = self.rawdata.find(']]>', i)
  ///             if k == -1:
  ///                 # CDATA block began but didn't finish
  ///                 k = len(self.rawdata)
  ///                 return k
  ///             self.handle_data(xml.sax.saxutils.escape(self.rawdata[i+9:k]), 0)
  ///             return k+3
  ///         else:
  ///             k = self.rawdata.find('>', i)
  ///             if k >= 0:
  ///                 return k+1
  ///             else:
  ///                 # We have an incomplete CDATA block.
  ///                 return k
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

  /// ## pop
  ///
  /// ### python source
  /// ```py
  /// def pop(self, element, strip_whitespace=1):
  ///         if not self.elementstack:
  ///             return
  ///         if self.elementstack[-1][0] != element:
  ///             return
  ///
  ///         element, expecting_text, pieces = self.elementstack.pop()
  ///
  ///         # Ensure each piece is a str for Python 3
  ///         for (i, v) in enumerate(pieces):
  ///             if isinstance(v, bytes):
  ///                 pieces[i] = v.decode('utf-8')
  ///
  ///         if self.version == 'atom10' and self.contentparams.get('type', 'text') == 'application/xhtml+xml':
  ///             # remove enclosing child element, but only if it is a <div> and
  ///             # only if all the remaining content is nested underneath it.
  ///             # This means that the divs would be retained in the following:
  ///             #    <div>foo</div><div>bar</div>
  ///             while pieces and len(pieces) > 1 and not pieces[-1].strip():
  ///                 del pieces[-1]
  ///             while pieces and len(pieces) > 1 and not pieces[0].strip():
  ///                 del pieces[0]
  ///             if pieces and (pieces[0] == '<div>' or pieces[0].startswith('<div ')) and pieces[-1] == '</div>':
  ///                 depth = 0
  ///                 for piece in pieces[:-1]:
  ///                     if piece.startswith('</'):
  ///                         depth -= 1
  ///                         if depth == 0:
  ///                             break
  ///                     elif piece.startswith('<') and not piece.endswith('/>'):
  ///                         depth += 1
  ///                 else:
  ///                     pieces = pieces[1:-1]
  ///
  ///         output = ''.join(pieces)
  ///         if strip_whitespace:
  ///             output = output.strip()
  ///         if not expecting_text:
  ///             return output
  ///
  ///         # decode base64 content
  ///         if base64 and self.contentparams.get('base64', 0):
  ///             try:
  ///                 output = base64.decodebytes(output.encode('utf8')).decode('utf8')
  ///             except (binascii.Error, binascii.Incomplete, UnicodeDecodeError):
  ///                 pass
  ///
  ///         # resolve relative URIs
  ///         if (element in self.can_be_relative_uri) and output:
  ///             # do not resolve guid elements with isPermalink="false"
  ///             if not element == 'id' or self.guidislink:
  ///                 output = self.resolve_uri(output)
  ///
  ///         # decode entities within embedded markup
  ///         if not self.contentparams.get('base64', 0):
  ///             output = self.decode_entities(element, output)
  ///
  ///         # some feed formats require consumers to guess
  ///         # whether the content is html or plain text
  ///         if not self.version.startswith('atom') and self.contentparams.get('type') == 'text/plain':
  ///             if self.looks_like_html(output):
  ///                 self.contentparams['type'] = 'text/html'
  ///
  ///         # remove temporary cruft from contentparams
  ///         try:
  ///             del self.contentparams['mode']
  ///         except KeyError:
  ///             pass
  ///         try:
  ///             del self.contentparams['base64']
  ///         except KeyError:
  ///             pass
  ///
  ///         is_htmlish = self.map_content_type(self.contentparams.get('type', 'text/html')) in self.html_types
  ///         # resolve relative URIs within embedded markup
  ///         if is_htmlish and self.resolve_relative_uris:
  ///             if element in self.can_contain_relative_uris:
  ///                 output = resolve_relative_uris(output, self.baseuri, self.encoding, self.contentparams.get('type', 'text/html'))
  ///
  ///         # sanitize embedded markup
  ///         if is_htmlish and self.sanitize_html:
  ///             if element in self.can_contain_dangerous_markup:
  ///                 output = _sanitize_html(output, self.encoding, self.contentparams.get('type', 'text/html'))
  ///
  ///         if self.encoding and isinstance(output, bytes):
  ///             output = output.decode(self.encoding, 'ignore')
  ///
  ///         # address common error where people take data that is already
  ///         # utf-8, presume that it is iso-8859-1, and re-encode it.
  ///         if self.encoding in ('utf-8', 'utf-8_INVALID_PYTHON_3') and not isinstance(output, bytes):
  ///             try:
  ///                 output = output.encode('iso-8859-1').decode('utf-8')
  ///             except (UnicodeEncodeError, UnicodeDecodeError):
  ///                 pass
  ///
  ///         # map win-1252 extensions to the proper code points
  ///         if not isinstance(output, bytes):
  ///             output = output.translate(_cp1252)
  ///
  ///         # categories/tags/keywords/whatever are handled in _end_category or
  ///         # _end_tags or _end_itunes_keywords
  ///         if element in ('category', 'tags', 'itunes_keywords'):
  ///             return output
  ///
  ///         if element == 'title' and -1 < self.title_depth <= self.depth:
  ///             return output
  ///
  ///         # store output in appropriate place(s)
  ///         if self.inentry and not self.insource:
  ///             if element == 'content':
  ///                 self.entries[-1].setdefault(element, [])
  ///                 contentparams = copy.deepcopy(self.contentparams)
  ///                 contentparams['value'] = output
  ///                 self.entries[-1][element].append(contentparams)
  ///             elif element == 'link':
  ///                 if not self.inimage:
  ///                     # query variables in urls in link elements are improperly
  ///                     # converted from `?a=1&b=2` to `?a=1&b;=2` as if they're
  ///                     # unhandled character references. fix this special case.
  ///                     output = output.replace('&amp;', '&')
  ///                     output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
  ///                     self.entries[-1][element] = output
  ///                     if output:
  ///                         self.entries[-1]['links'][-1]['href'] = output
  ///             else:
  ///                 if element == 'description':
  ///                     element = 'summary'
  ///                 old_value_depth = self.property_depth_map.setdefault(self.entries[-1], {}).get(element)
  ///                 if old_value_depth is None or self.depth <= old_value_depth:
  ///                     self.property_depth_map[self.entries[-1]][element] = self.depth
  ///                     self.entries[-1][element] = output
  ///                 if self.incontent:
  ///                     contentparams = copy.deepcopy(self.contentparams)
  ///                     contentparams['value'] = output
  ///                     self.entries[-1][element + '_detail'] = contentparams
  ///         elif self.infeed or self.insource:  # and (not self.intextinput) and (not self.inimage):
  ///             context = self._get_context()
  ///             if element == 'description':
  ///                 element = 'subtitle'
  ///             context[element] = output
  ///             if element == 'link':
  ///                 # fix query variables; see above for the explanation
  ///                 output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
  ///                 context[element] = output
  ///                 context['links'][-1]['href'] = output
  ///             elif self.incontent:
  ///                 contentparams = copy.deepcopy(self.contentparams)
  ///                 contentparams['value'] = output
  ///                 context[element + '_detail'] = contentparams
  ///         return output
  /// ```
  Object? pop({
    required Object? element,
    Object? strip_whitespace = 1,
  }) =>
      getFunction("pop").call(
        <Object?>[
          element,
          strip_whitespace,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## pop_content
  ///
  /// ### python source
  /// ```py
  /// def pop_content(self, tag):
  ///         value = self.pop(tag)
  ///         self.incontent -= 1
  ///         self.contentparams.clear()
  ///         return value
  /// ```
  Object? pop_content({
    required Object? tag,
  }) =>
      getFunction("pop_content").call(
        <Object?>[
          tag,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## push
  ///
  /// ### python source
  /// ```py
  /// def push(self, element, expecting_text):
  ///         self.elementstack.append([element, expecting_text, []])
  /// ```
  Object? push({
    required Object? element,
    required Object? expecting_text,
  }) =>
      getFunction("push").call(
        <Object?>[
          element,
          expecting_text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## push_content
  ///
  /// ### python source
  /// ```py
  /// def push_content(self, tag, attrs_d, default_content_type, expecting_text):
  ///         self.incontent += 1
  ///         if self.lang:
  ///             self.lang = self.lang.replace('_', '-')
  ///         self.contentparams = FeedParserDict({
  ///             'type': self.map_content_type(attrs_d.get('type', default_content_type)),
  ///             'language': self.lang,
  ///             'base': self.baseuri})
  ///         self.contentparams['base64'] = self._is_base64(attrs_d, self.contentparams)
  ///         self.push(tag, expecting_text)
  /// ```
  Object? push_content({
    required Object? tag,
    required Object? attrs_d,
    required Object? default_content_type,
    required Object? expecting_text,
  }) =>
      getFunction("push_content").call(
        <Object?>[
          tag,
          attrs_d,
          default_content_type,
          expecting_text,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## resolve_uri
  ///
  /// ### python source
  /// ```py
  /// def resolve_uri(self, uri):
  ///         return _urljoin(self.baseuri or '', uri)
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

  /// ## startElementNS
  ///
  /// ### python source
  /// ```py
  /// def startElementNS(self, name, qname, attrs):
  ///         namespace, localname = name
  ///         lowernamespace = str(namespace or '').lower()
  ///         if lowernamespace.find('backend.userland.com/rss') != -1:
  ///             # match any backend.userland.com namespace
  ///             namespace = 'http://backend.userland.com/rss'
  ///             lowernamespace = namespace
  ///         if qname and qname.find(':') > 0:
  ///             givenprefix = qname.split(':')[0]
  ///         else:
  ///             givenprefix = None
  ///         prefix = self._matchnamespaces.get(lowernamespace, givenprefix)
  ///         if givenprefix and (prefix is None or (prefix == '' and lowernamespace == '')) and givenprefix not in self.namespaces_in_use:
  ///             raise UndeclaredNamespace("'%s' is not associated with a namespace" % givenprefix)
  ///         localname = str(localname).lower()
  ///
  ///         # qname implementation is horribly broken in Python 2.1 (it
  ///         # doesn't report any), and slightly broken in Python 2.2 (it
  ///         # doesn't report the xml: namespace). So we match up namespaces
  ///         # with a known list first, and then possibly override them with
  ///         # the qnames the SAX parser gives us (if indeed it gives us any
  ///         # at all).  Thanks to MatejC for helping me test this and
  ///         # tirelessly telling me that it didn't work yet.
  ///         attrsD, self.decls = self.decls, {}
  ///         if localname == 'math' and namespace == 'http://www.w3.org/1998/Math/MathML':
  ///             attrsD['xmlns'] = namespace
  ///         if localname == 'svg' and namespace == 'http://www.w3.org/2000/svg':
  ///             attrsD['xmlns'] = namespace
  ///
  ///         if prefix:
  ///             localname = prefix.lower() + ':' + localname
  ///         elif namespace and not qname:  # Expat
  ///             for name, value in self.namespaces_in_use.items():
  ///                 if name and value == namespace:
  ///                     localname = name + ':' + localname
  ///                     break
  ///
  ///         for (namespace, attrlocalname), attrvalue in attrs.items():
  ///             lowernamespace = (namespace or '').lower()
  ///             prefix = self._matchnamespaces.get(lowernamespace, '')
  ///             if prefix:
  ///                 attrlocalname = prefix + ':' + attrlocalname
  ///             attrsD[str(attrlocalname).lower()] = attrvalue
  ///         for qname in attrs.getQNames():
  ///             attrsD[str(qname).lower()] = attrs.getValueByQName(qname)
  ///         localname = str(localname).lower()
  ///         self.unknown_starttag(localname, list(attrsD.items()))
  /// ```
  Object? startElementNS({
    required Object? name,
    required Object? qname,
    required Object? attrs,
  }) =>
      getFunction("startElementNS").call(
        <Object?>[
          name,
          qname,
          attrs,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## startPrefixMapping
  ///
  /// ### python source
  /// ```py
  /// def startPrefixMapping(self, prefix, uri):
  ///         if not uri:
  ///             return
  ///         # Jython uses '' instead of None; standardize on None
  ///         prefix = prefix or None
  ///         self.track_namespace(prefix, uri)
  ///         if prefix and uri == 'http://www.w3.org/1999/xlink':
  ///             self.decls['xmlns:' + prefix] = uri
  /// ```
  Object? startPrefixMapping({
    required Object? prefix,
    required Object? uri,
  }) =>
      getFunction("startPrefixMapping").call(
        <Object?>[
          prefix,
          uri,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## strattrs
  ///
  /// ### python source
  /// ```py
  /// @staticmethod
  ///     def strattrs(attrs):
  ///         return ''.join(
  ///             ' %s="%s"' % (t[0], xml.sax.saxutils.escape(t[1], {'"': '&quot;'}))
  ///             for t in attrs
  ///         )
  /// ```
  Object? strattrs() => getFunction("strattrs").call(
        <Object?>[],
        kwargs: <String, Object?>{},
      );

  /// ## track_namespace
  ///
  /// ### python source
  /// ```py
  /// def track_namespace(self, prefix, uri):
  ///         loweruri = uri.lower()
  ///         if not self.version:
  ///             if (prefix, loweruri) == (None, 'http://my.netscape.com/rdf/simple/0.9/'):
  ///                 self.version = 'rss090'
  ///             elif loweruri == 'http://purl.org/rss/1.0/':
  ///                 self.version = 'rss10'
  ///             elif loweruri == 'http://www.w3.org/2005/atom':
  ///                 self.version = 'atom10'
  ///         if loweruri.find('backend.userland.com/rss') != -1:
  ///             # match any backend.userland.com namespace
  ///             uri = 'http://backend.userland.com/rss'
  ///             loweruri = uri
  ///         if loweruri in self._matchnamespaces:
  ///             self.namespacemap[prefix] = self._matchnamespaces[loweruri]
  ///             self.namespaces_in_use[self._matchnamespaces[loweruri]] = uri
  ///         else:
  ///             self.namespaces_in_use[prefix or ''] = uri
  /// ```
  Object? track_namespace({
    required Object? prefix,
    required Object? uri,
  }) =>
      getFunction("track_namespace").call(
        <Object?>[
          prefix,
          uri,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## unknown_endtag
  ///
  /// ### python source
  /// ```py
  /// def unknown_endtag(self, tag):
  ///         # match namespaces
  ///         if tag.find(':') != -1:
  ///             prefix, suffix = tag.split(':', 1)
  ///         else:
  ///             prefix, suffix = '', tag
  ///         prefix = self.namespacemap.get(prefix, prefix)
  ///         if prefix:
  ///             prefix = prefix + '_'
  ///         if suffix == 'svg' and self.svgOK:
  ///             self.svgOK -= 1
  ///
  ///         # call special handler (if defined) or default handler
  ///         methodname = '_end_' + prefix + suffix
  ///         try:
  ///             if self.svgOK:
  ///                 raise AttributeError()
  ///             method = getattr(self, methodname)
  ///             method()
  ///         except AttributeError:
  ///             self.pop(prefix + suffix)
  ///
  ///         # track inline content
  ///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
  ///             # element declared itself as escaped markup, but it isn't really
  ///             if tag in ('xhtml:div', 'div'):
  ///                 return  # typepad does this 10/2007
  ///             self.contentparams['type'] = 'application/xhtml+xml'
  ///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             tag = tag.split(':')[-1]
  ///             self.handle_data('</%s>' % tag, escape=0)
  ///
  ///         # track xml:base and xml:lang going out of scope
  ///         if self.basestack:
  ///             self.basestack.pop()
  ///             if self.basestack and self.basestack[-1]:
  ///                 self.baseuri = self.basestack[-1]
  ///         if self.langstack:
  ///             self.langstack.pop()
  ///             if self.langstack:  # and (self.langstack[-1] is not None):
  ///                 self.lang = self.langstack[-1]
  ///
  ///         self.depth -= 1
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

  /// ## unknown_starttag
  ///
  /// ### python source
  /// ```py
  /// def unknown_starttag(self, tag, attrs):
  ///         # increment depth counter
  ///         self.depth += 1
  ///
  ///         # normalize attrs
  ///         attrs = [self._normalize_attributes(attr) for attr in attrs]
  ///
  ///         # track xml:base and xml:lang
  ///         attrs_d = dict(attrs)
  ///         baseuri = attrs_d.get('xml:base', attrs_d.get('base')) or self.baseuri
  ///         if isinstance(baseuri, bytes):
  ///             baseuri = baseuri.decode(self.encoding, 'ignore')
  ///         # ensure that self.baseuri is always an absolute URI that
  ///         # uses a whitelisted URI scheme (e.g. not `javscript:`)
  ///         if self.baseuri:
  ///             self.baseuri = make_safe_absolute_uri(self.baseuri, baseuri) or self.baseuri
  ///         else:
  ///             self.baseuri = _urljoin(self.baseuri, baseuri)
  ///         lang = attrs_d.get('xml:lang', attrs_d.get('lang'))
  ///         if lang == '':
  ///             # xml:lang could be explicitly set to '', we need to capture that
  ///             lang = None
  ///         elif lang is None:
  ///             # if no xml:lang is specified, use parent lang
  ///             lang = self.lang
  ///         if lang:
  ///             if tag in ('feed', 'rss', 'rdf:RDF'):
  ///                 self.feeddata['language'] = lang.replace('_', '-')
  ///         self.lang = lang
  ///         self.basestack.append(self.baseuri)
  ///         self.langstack.append(lang)
  ///
  ///         # track namespaces
  ///         for prefix, uri in attrs:
  ///             if prefix.startswith('xmlns:'):
  ///                 self.track_namespace(prefix[6:], uri)
  ///             elif prefix == 'xmlns':
  ///                 self.track_namespace(None, uri)
  ///
  ///         # track inline content
  ///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
  ///             if tag in ('xhtml:div', 'div'):
  ///                 return  # typepad does this 10/2007
  ///             # element declared itself as escaped markup, but it isn't really
  ///             self.contentparams['type'] = 'application/xhtml+xml'
  ///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
  ///             if tag.find(':') != -1:
  ///                 prefix, tag = tag.split(':', 1)
  ///                 namespace = self.namespaces_in_use.get(prefix, '')
  ///                 if tag == 'math' and namespace == 'http://www.w3.org/1998/Math/MathML':
  ///                     attrs.append(('xmlns', namespace))
  ///                 if tag == 'svg' and namespace == 'http://www.w3.org/2000/svg':
  ///                     attrs.append(('xmlns', namespace))
  ///             if tag == 'svg':
  ///                 self.svgOK += 1
  ///             return self.handle_data('<%s%s>' % (tag, self.strattrs(attrs)), escape=0)
  ///
  ///         # match namespaces
  ///         if tag.find(':') != -1:
  ///             prefix, suffix = tag.split(':', 1)
  ///         else:
  ///             prefix, suffix = '', tag
  ///         prefix = self.namespacemap.get(prefix, prefix)
  ///         if prefix:
  ///             prefix = prefix + '_'
  ///
  ///         # Special hack for better tracking of empty textinput/image elements in
  ///         # illformed feeds.
  ///         if (not prefix) and tag not in ('title', 'link', 'description', 'name'):
  ///             self.intextinput = 0
  ///         if (not prefix) and tag not in ('title', 'link', 'description', 'url', 'href', 'width', 'height'):
  ///             self.inimage = 0
  ///
  ///         # call special handler (if defined) or default handler
  ///         methodname = '_start_' + prefix + suffix
  ///         try:
  ///             method = getattr(self, methodname)
  ///             return method(attrs_d)
  ///         except AttributeError:
  ///             # Since there's no handler or something has gone wrong we
  ///             # explicitly add the element and its attributes.
  ///             unknown_tag = prefix + suffix
  ///             if len(attrs_d) == 0:
  ///                 # No attributes so merge it into the enclosing dictionary
  ///                 return self.push(unknown_tag, 1)
  ///             else:
  ///                 # Has attributes so create it in its own dictionary
  ///                 context = self._get_context()
  ///                 context[unknown_tag] = attrs_d
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

  /// ## can_be_relative_uri (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_be_relative_uri => getAttribute("can_be_relative_uri");

  /// ## can_be_relative_uri (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_be_relative_uri(Object? can_be_relative_uri) =>
      setAttribute("can_be_relative_uri", can_be_relative_uri);

  /// ## can_contain_dangerous_markup (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_contain_dangerous_markup =>
      getAttribute("can_contain_dangerous_markup");

  /// ## can_contain_dangerous_markup (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_contain_dangerous_markup(Object? can_contain_dangerous_markup) =>
      setAttribute(
          "can_contain_dangerous_markup", can_contain_dangerous_markup);

  /// ## can_contain_relative_uris (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get can_contain_relative_uris =>
      getAttribute("can_contain_relative_uris");

  /// ## can_contain_relative_uris (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set can_contain_relative_uris(Object? can_contain_relative_uris) =>
      setAttribute("can_contain_relative_uris", can_contain_relative_uris);

  /// ## html_types (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get html_types => getAttribute("html_types");

  /// ## html_types (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set html_types(Object? html_types) => setAttribute("html_types", html_types);

  /// ## namespaces (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get namespaces => getAttribute("namespaces");

  /// ## namespaces (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set namespaces(Object? namespaces) => setAttribute("namespaces", namespaces);

  /// ## supported_namespaces (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get supported_namespaces => getAttribute("supported_namespaces");

  /// ## supported_namespaces (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set supported_namespaces(Object? supported_namespaces) =>
      setAttribute("supported_namespaces", supported_namespaces);

  /// ## bozo (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get bozo => getAttribute("bozo");

  /// ## bozo (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set bozo(Object? bozo) => setAttribute("bozo", bozo);

  /// ## exc (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get exc => getAttribute("exc");

  /// ## exc (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set exc(Object? exc) => setAttribute("exc", exc);

  /// ## decls (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get decls => getAttribute("decls");

  /// ## decls (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set decls(Object? decls) => setAttribute("decls", decls);

  /// ## baseuri (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get baseuri => getAttribute("baseuri");

  /// ## baseuri (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set baseuri(Object? baseuri) => setAttribute("baseuri", baseuri);

  /// ## lang (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get lang => getAttribute("lang");

  /// ## lang (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set lang(Object? lang) => setAttribute("lang", lang);

  /// ## encoding (getter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  Object? get encoding => getAttribute("encoding");

  /// ## encoding (setter)
  ///
  /// ### python docstring
  ///
  /// Support for the Atom, RSS, RDF, and CDF feed formats.
  ///
  /// The feed formats all share common elements, some of which have conflicting
  /// interpretations. For simplicity, all of the base feed format support is
  /// collected here.
  set encoding(Object? encoding) => setAttribute("encoding", encoding);
}

/// ## ThingsNobodyCaresAboutButMe
///
/// ### python source
/// ```py
/// class ThingsNobodyCaresAboutButMe(Exception):
///     pass
/// ```
final class ThingsNobodyCaresAboutButMe extends PythonClass {
  factory ThingsNobodyCaresAboutButMe() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "ThingsNobodyCaresAboutButMe",
        ThingsNobodyCaresAboutButMe.from,
        <Object?>[],
      );

  ThingsNobodyCaresAboutButMe.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## UndeclaredNamespace
///
/// ### python source
/// ```py
/// class UndeclaredNamespace(Exception):
///     pass
/// ```
final class UndeclaredNamespace extends PythonClass {
  factory UndeclaredNamespace() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "UndeclaredNamespace",
        UndeclaredNamespace.from,
        <Object?>[],
      );

  UndeclaredNamespace.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## error
final class error extends PythonClass {
  factory error() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "error",
        error.from,
        <Object?>[],
      );

  error.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Error
final class Error extends PythonClass {
  factory Error() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "Error",
        Error.from,
        <Object?>[],
      );

  Error.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Incomplete
final class Incomplete extends PythonClass {
  factory Incomplete() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "Incomplete",
        Incomplete.from,
        <Object?>[],
      );

  Incomplete.from(super.pythonClass) : super.from();

  /// ## args (getter)
  Object? get args => getAttribute("args");

  /// ## args (setter)
  set args(Object? args) => setAttribute("args", args);

  /// ## add_note (getter)
  Object? get add_note => getAttribute("add_note");

  /// ## add_note (setter)
  set add_note(Object? add_note) => setAttribute("add_note", add_note);

  /// ## with_traceback (getter)
  Object? get with_traceback => getAttribute("with_traceback");

  /// ## with_traceback (setter)
  set with_traceback(Object? with_traceback) =>
      setAttribute("with_traceback", with_traceback);
}

/// ## Namespace
///
/// ### python source
/// ```py
/// class Namespace(object):
///     supported_namespaces = {
///         # RDF-based namespace
///         'http://creativecommons.org/ns#license': 'cc',
///
///         # Old RDF-based namespace
///         'http://web.resource.org/cc/': 'cc',
///
///         # RSS-based namespace
///         'http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html': 'creativecommons',
///
///         # Old RSS-based namespace
///         'http://backend.userland.com/creativeCommonsRssModule': 'creativecommons',
///     }
///
///     def _start_cc_license(self, attrs_d):
///         context = self._get_context()
///         value = self._get_attribute(attrs_d, 'rdf:resource')
///         attrs_d = FeedParserDict()
///         attrs_d['rel'] = 'license'
///         if value:
///             attrs_d['href'] = value
///         context.setdefault('links', []).append(attrs_d)
///
///     def _start_creativecommons_license(self, attrs_d):
///         self.push('license', 1)
///     _start_creativeCommons_license = _start_creativecommons_license
///
///     def _end_creativecommons_license(self):
///         value = self.pop('license')
///         context = self._get_context()
///         attrs_d = FeedParserDict()
///         attrs_d['rel'] = 'license'
///         if value:
///             attrs_d['href'] = value
///         context.setdefault('links', []).append(attrs_d)
///         del context['license']
///     _end_creativeCommons_license = _end_creativecommons_license
/// ```
final class Namespace extends PythonClass {
  factory Namespace() => PythonFfiDart.instance.importClass(
        "feedparser.api",
        "Namespace",
        Namespace.from,
        <Object?>[],
      );

  Namespace.from(super.pythonClass) : super.from();

  /// ## supported_namespaces (getter)
  Object? get supported_namespaces => getAttribute("supported_namespaces");

  /// ## supported_namespaces (setter)
  set supported_namespaces(Object? supported_namespaces) =>
      setAttribute("supported_namespaces", supported_namespaces);
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
        "feedparser.api",
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
        "feedparser.api",
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
        "feedparser.api",
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

/// ## api
///
/// ### python source
/// ```py
/// # The public API for feedparser
/// # Copyright 2010-2022 Kurt McKee <contactme@kurtmckee.org>
/// # Copyright 2002-2008 Mark Pilgrim
/// # All rights reserved.
/// #
/// # This file is a part of feedparser.
/// #
/// # Redistribution and use in source and binary forms, with or without modification,
/// # are permitted provided that the following conditions are met:
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
/// import io
/// import urllib.error
/// import urllib.parse
/// import xml.sax
///
/// from .datetimes import registerDateHandler, _parse_date
/// from .encodings import convert_to_utf8
/// from .exceptions import *
/// from .html import _BaseHTMLProcessor
/// from . import http
/// from . import mixin
/// from .mixin import _FeedParserMixin
/// from .parsers.loose import _LooseFeedParser
/// from .parsers.strict import _StrictFeedParser
/// from .sanitizer import replace_doctype
/// from .sgml import *
/// from .urls import convert_to_idn, make_safe_absolute_uri
/// from .util import FeedParserDict
///
///
/// # List of preferred XML parsers, by SAX driver name.  These will be tried first,
/// # but if they're not installed, Python will keep searching through its own list
/// # of pre-installed parsers until it finds one that supports everything we need.
/// PREFERRED_XML_PARSERS = ["drv_libxml2"]
///
/// _XML_AVAILABLE = True
///
/// SUPPORTED_VERSIONS = {
///     '': 'unknown',
///     'rss090': 'RSS 0.90',
///     'rss091n': 'RSS 0.91 (Netscape)',
///     'rss091u': 'RSS 0.91 (Userland)',
///     'rss092': 'RSS 0.92',
///     'rss093': 'RSS 0.93',
///     'rss094': 'RSS 0.94',
///     'rss20': 'RSS 2.0',
///     'rss10': 'RSS 1.0',
///     'rss': 'RSS (unknown version)',
///     'atom01': 'Atom 0.1',
///     'atom02': 'Atom 0.2',
///     'atom03': 'Atom 0.3',
///     'atom10': 'Atom 1.0',
///     'atom': 'Atom (unknown version)',
///     'cdf': 'CDF',
/// }
///
///
/// def _open_resource(url_file_stream_or_string, etag, modified, agent, referrer, handlers, request_headers, result):
///     """URL, filename, or string --> stream
///
///     This function lets you define parsers that take any input source
///     (URL, pathname to local or network file, or actual data as a string)
///     and deal with it in a uniform manner.  Returned object is guaranteed
///     to have all the basic stdio read methods (read, readline, readlines).
///     Just .close() the object when you're done with it.
///
///     If the etag argument is supplied, it will be used as the value of an
///     If-None-Match request header.
///
///     If the modified argument is supplied, it can be a tuple of 9 integers
///     (as returned by gmtime() in the standard Python time module) or a date
///     string in any format supported by feedparser. Regardless, it MUST
///     be in GMT (Greenwich Mean Time). It will be reformatted into an
///     RFC 1123-compliant date and used as the value of an If-Modified-Since
///     request header.
///
///     If the agent argument is supplied, it will be used as the value of a
///     User-Agent request header.
///
///     If the referrer argument is supplied, it will be used as the value of a
///     Referer[sic] request header.
///
///     If handlers is supplied, it is a list of handlers used to build a
///     urllib2 opener.
///
///     if request_headers is supplied it is a dictionary of HTTP request headers
///     that will override the values generated by FeedParser.
///
///     :return: A bytes object.
///     """
///
///     if hasattr(url_file_stream_or_string, 'read'):
///         return url_file_stream_or_string.read()
///
///     if isinstance(url_file_stream_or_string, str) \
///        and urllib.parse.urlparse(url_file_stream_or_string)[0] in ('http', 'https', 'ftp', 'file', 'feed'):
///         return http.get(url_file_stream_or_string, etag, modified, agent, referrer, handlers, request_headers, result)
///
///     # try to open with native open function (if url_file_stream_or_string is a filename)
///     try:
///         with open(url_file_stream_or_string, 'rb') as f:
///             data = f.read()
///     except (IOError, UnicodeEncodeError, TypeError, ValueError):
///         # if url_file_stream_or_string is a str object that
///         # cannot be converted to the encoding returned by
///         # sys.getfilesystemencoding(), a UnicodeEncodeError
///         # will be thrown
///         # If url_file_stream_or_string is a string that contains NULL
///         # (such as an XML document encoded in UTF-32), TypeError will
///         # be thrown.
///         pass
///     else:
///         return data
///
///     # treat url_file_stream_or_string as string
///     if not isinstance(url_file_stream_or_string, bytes):
///         return url_file_stream_or_string.encode('utf-8')
///     return url_file_stream_or_string
///
///
/// LooseFeedParser = type(
///     'LooseFeedParser',
///     (_LooseFeedParser, _FeedParserMixin, _BaseHTMLProcessor, object),
///     {},
/// )
///
/// StrictFeedParser = type(
///     'StrictFeedParser',
///     (_StrictFeedParser, _FeedParserMixin, xml.sax.handler.ContentHandler, object),
///     {},
/// )
///
///
/// def parse(url_file_stream_or_string, etag=None, modified=None, agent=None, referrer=None, handlers=None, request_headers=None, response_headers=None, resolve_relative_uris=None, sanitize_html=None):
///     """Parse a feed from a URL, file, stream, or string.
///
///     :param url_file_stream_or_string:
///         File-like object, URL, file path, or string. Both byte and text strings
///         are accepted. If necessary, encoding will be derived from the response
///         headers or automatically detected.
///
///         Note that strings may trigger network I/O or filesystem access
///         depending on the value. Wrap an untrusted string in
///         a :class:`io.StringIO` or :class:`io.BytesIO` to avoid this. Do not
///         pass untrusted strings to this function.
///
///         When a URL is not passed the feed location to use in relative URL
///         resolution should be passed in the ``Content-Location`` response header
///         (see ``response_headers`` below).
///
///     :param str etag: HTTP ``ETag`` request header.
///     :param modified: HTTP ``Last-Modified`` request header.
///     :type modified: :class:`str`, :class:`time.struct_time` 9-tuple, or
///         :class:`datetime.datetime`
///     :param str agent: HTTP ``User-Agent`` request header, which defaults to
///         the value of :data:`feedparser.USER_AGENT`.
///     :param referrer: HTTP ``Referer`` [sic] request header.
///     :param request_headers:
///         A mapping of HTTP header name to HTTP header value to add to the
///         request, overriding internally generated values.
///     :type request_headers: :class:`dict` mapping :class:`str` to :class:`str`
///     :param response_headers:
///         A mapping of HTTP header name to HTTP header value. Multiple values may
///         be joined with a comma. If a HTTP request was made, these headers
///         override any matching headers in the response. Otherwise this specifies
///         the entirety of the response headers.
///     :type response_headers: :class:`dict` mapping :class:`str` to :class:`str`
///
///     :param bool resolve_relative_uris:
///         Should feedparser attempt to resolve relative URIs absolute ones within
///         HTML content?  Defaults to the value of
///         :data:`feedparser.RESOLVE_RELATIVE_URIS`, which is ``True``.
///     :param bool sanitize_html:
///         Should feedparser skip HTML sanitization? Only disable this if you know
///         what you are doing!  Defaults to the value of
///         :data:`feedparser.SANITIZE_HTML`, which is ``True``.
///
///     :return: A :class:`FeedParserDict`.
///     """
///
///     if not agent or sanitize_html is None or resolve_relative_uris is None:
///         import feedparser
///     if not agent:
///         agent = feedparser.USER_AGENT
///     if sanitize_html is None:
///         sanitize_html = feedparser.SANITIZE_HTML
///     if resolve_relative_uris is None:
///         resolve_relative_uris = feedparser.RESOLVE_RELATIVE_URIS
///
///     result = FeedParserDict(
///         bozo=False,
///         entries=[],
///         feed=FeedParserDict(),
///         headers={},
///     )
///
///     try:
///         data = _open_resource(url_file_stream_or_string, etag, modified, agent, referrer, handlers, request_headers, result)
///     except urllib.error.URLError as error:
///         result.update({
///             'bozo': True,
///             'bozo_exception': error,
///         })
///         return result
///
///     if not data:
///         return result
///
///     # overwrite existing headers using response_headers
///     result['headers'].update(response_headers or {})
///
///     data = convert_to_utf8(result['headers'], data, result)
///     use_strict_parser = result['encoding'] and True or False
///
///     result['version'], data, entities = replace_doctype(data)
///
///     # Ensure that baseuri is an absolute URI using an acceptable URI scheme.
///     contentloc = result['headers'].get('content-location', '')
///     href = result.get('href', '')
///     baseuri = make_safe_absolute_uri(href, contentloc) or make_safe_absolute_uri(contentloc) or href
///
///     baselang = result['headers'].get('content-language', None)
///     if isinstance(baselang, bytes) and baselang is not None:
///         baselang = baselang.decode('utf-8', 'ignore')
///
///     if not _XML_AVAILABLE:
///         use_strict_parser = 0
///     if use_strict_parser:
///         # initialize the SAX parser
///         feedparser = StrictFeedParser(baseuri, baselang, 'utf-8')
///         feedparser.resolve_relative_uris = resolve_relative_uris
///         feedparser.sanitize_html = sanitize_html
///         saxparser = xml.sax.make_parser(PREFERRED_XML_PARSERS)
///         saxparser.setFeature(xml.sax.handler.feature_namespaces, 1)
///         try:
///             # disable downloading external doctype references, if possible
///             saxparser.setFeature(xml.sax.handler.feature_external_ges, 0)
///         except xml.sax.SAXNotSupportedException:
///             pass
///         saxparser.setContentHandler(feedparser)
///         saxparser.setErrorHandler(feedparser)
///         source = xml.sax.xmlreader.InputSource()
///         source.setByteStream(io.BytesIO(data))
///         try:
///             saxparser.parse(source)
///         except xml.sax.SAXException as e:
///             result['bozo'] = 1
///             result['bozo_exception'] = feedparser.exc or e
///             use_strict_parser = 0
///     if not use_strict_parser:
///         feedparser = LooseFeedParser(baseuri, baselang, 'utf-8', entities)
///         feedparser.resolve_relative_uris = resolve_relative_uris
///         feedparser.sanitize_html = sanitize_html
///         feedparser.feed(data.decode('utf-8', 'replace'))
///     result['feed'] = feedparser.feeddata
///     result['entries'] = feedparser.entries
///     result['version'] = result['version'] or feedparser.version
///     result['namespaces'] = feedparser.namespaces_in_use
///     return result
/// ```
final class api extends PythonModule {
  api.from(super.pythonModule) : super.from();

  static api import() => PythonFfiDart.instance.importModule(
        "feedparser.api",
        api.from,
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

  /// ## convert_to_utf8
  ///
  /// ### python docstring
  ///
  /// Detect and convert the character encoding to UTF-8.
  ///
  /// http_headers is a dictionary
  /// data is a raw string (not Unicode)
  ///
  /// ### python source
  /// ```py
  /// def convert_to_utf8(http_headers, data, result):
  ///     """Detect and convert the character encoding to UTF-8.
  ///
  ///     http_headers is a dictionary
  ///     data is a raw string (not Unicode)"""
  ///
  ///     # This is so much trickier than it sounds, it's not even funny.
  ///     # According to RFC 3023 ('XML Media Types'), if the HTTP Content-Type
  ///     # is application/xml, application/*+xml,
  ///     # application/xml-external-parsed-entity, or application/xml-dtd,
  ///     # the encoding given in the charset parameter of the HTTP Content-Type
  ///     # takes precedence over the encoding given in the XML prefix within the
  ///     # document, and defaults to 'utf-8' if neither are specified.  But, if
  ///     # the HTTP Content-Type is text/xml, text/*+xml, or
  ///     # text/xml-external-parsed-entity, the encoding given in the XML prefix
  ///     # within the document is ALWAYS IGNORED and only the encoding given in
  ///     # the charset parameter of the HTTP Content-Type header should be
  ///     # respected, and it defaults to 'us-ascii' if not specified.
  ///
  ///     # Furthermore, discussion on the atom-syntax mailing list with the
  ///     # author of RFC 3023 leads me to the conclusion that any document
  ///     # served with a Content-Type of text/* and no charset parameter
  ///     # must be treated as us-ascii.  (We now do this.)  And also that it
  ///     # must always be flagged as non-well-formed.  (We now do this too.)
  ///
  ///     # If Content-Type is unspecified (input was local file or non-HTTP source)
  ///     # or unrecognized (server just got it totally wrong), then go by the
  ///     # encoding given in the XML prefix of the document and default to
  ///     # 'iso-8859-1' as per the HTTP specification (RFC 2616).
  ///
  ///     # Then, assuming we didn't find a character encoding in the HTTP headers
  ///     # (and the HTTP Content-type allowed us to look in the body), we need
  ///     # to sniff the first few bytes of the XML data and try to determine
  ///     # whether the encoding is ASCII-compatible.  Section F of the XML
  ///     # specification shows the way here:
  ///     # http://www.w3.org/TR/REC-xml/#sec-guessing-no-ext-info
  ///
  ///     # If the sniffed encoding is not ASCII-compatible, we need to make it
  ///     # ASCII compatible so that we can sniff further into the XML declaration
  ///     # to find the encoding attribute, which will tell us the true encoding.
  ///
  ///     # Of course, none of this guarantees that we will be able to parse the
  ///     # feed in the declared character encoding (assuming it was declared
  ///     # correctly, which many are not).  iconv_codec can help a lot;
  ///     # you should definitely install it if you can.
  ///     # http://cjkpython.i18n.org/
  ///
  ///     bom_encoding = ''
  ///     xml_encoding = ''
  ///
  ///     # Look at the first few bytes of the document to guess what
  ///     # its encoding may be. We only need to decode enough of the
  ///     # document that we can use an ASCII-compatible regular
  ///     # expression to search for an XML encoding declaration.
  ///     # The heuristic follows the XML specification, section F:
  ///     # http://www.w3.org/TR/REC-xml/#sec-guessing-no-ext-info
  ///     # Check for BOMs first.
  ///     if data[:4] == codecs.BOM_UTF32_BE:
  ///         bom_encoding = 'utf-32be'
  ///         data = data[4:]
  ///     elif data[:4] == codecs.BOM_UTF32_LE:
  ///         bom_encoding = 'utf-32le'
  ///         data = data[4:]
  ///     elif data[:2] == codecs.BOM_UTF16_BE and data[2:4] != ZERO_BYTES:
  ///         bom_encoding = 'utf-16be'
  ///         data = data[2:]
  ///     elif data[:2] == codecs.BOM_UTF16_LE and data[2:4] != ZERO_BYTES:
  ///         bom_encoding = 'utf-16le'
  ///         data = data[2:]
  ///     elif data[:3] == codecs.BOM_UTF8:
  ///         bom_encoding = 'utf-8'
  ///         data = data[3:]
  ///     # Check for the characters '<?xm' in several encodings.
  ///     elif data[:4] == EBCDIC_MARKER:
  ///         bom_encoding = 'cp037'
  ///     elif data[:4] == UTF16BE_MARKER:
  ///         bom_encoding = 'utf-16be'
  ///     elif data[:4] == UTF16LE_MARKER:
  ///         bom_encoding = 'utf-16le'
  ///     elif data[:4] == UTF32BE_MARKER:
  ///         bom_encoding = 'utf-32be'
  ///     elif data[:4] == UTF32LE_MARKER:
  ///         bom_encoding = 'utf-32le'
  ///
  ///     tempdata = data
  ///     try:
  ///         if bom_encoding:
  ///             tempdata = data.decode(bom_encoding).encode('utf-8')
  ///     except (UnicodeDecodeError, LookupError):
  ///         # feedparser recognizes UTF-32 encodings that aren't
  ///         # available in Python 2.4 and 2.5, so it's possible to
  ///         # encounter a LookupError during decoding.
  ///         xml_encoding_match = None
  ///     else:
  ///         xml_encoding_match = RE_XML_PI_ENCODING.match(tempdata)
  ///
  ///     if xml_encoding_match:
  ///         xml_encoding = xml_encoding_match.groups()[0].decode('utf-8').lower()
  ///         # Normalize the xml_encoding if necessary.
  ///         if bom_encoding and (xml_encoding in (
  ///             'u16', 'utf-16', 'utf16', 'utf_16',
  ///             'u32', 'utf-32', 'utf32', 'utf_32',
  ///             'iso-10646-ucs-2', 'iso-10646-ucs-4',
  ///             'csucs4', 'csunicode', 'ucs-2', 'ucs-4'
  ///         )):
  ///             xml_encoding = bom_encoding
  ///
  ///     # Find the HTTP Content-Type and, hopefully, a character
  ///     # encoding provided by the server. The Content-Type is used
  ///     # to choose the "correct" encoding among the BOM encoding,
  ///     # XML declaration encoding, and HTTP encoding, following the
  ///     # heuristic defined in RFC 3023.
  ///     http_content_type = http_headers.get('content-type') or ''
  ///     http_content_type, params = cgi.parse_header(http_content_type)
  ///     http_encoding = params.get('charset', '').replace("'", "")
  ///     if isinstance(http_encoding, bytes):
  ///         http_encoding = http_encoding.decode('utf-8', 'ignore')
  ///
  ///     acceptable_content_type = 0
  ///     application_content_types = ('application/xml', 'application/xml-dtd',
  ///                                  'application/xml-external-parsed-entity')
  ///     text_content_types = ('text/xml', 'text/xml-external-parsed-entity')
  ///     if (
  ///             http_content_type in application_content_types
  ///             or (
  ///                     http_content_type.startswith('application/')
  ///                     and http_content_type.endswith('+xml')
  ///             )
  ///     ):
  ///         acceptable_content_type = 1
  ///         rfc3023_encoding = http_encoding or xml_encoding or 'utf-8'
  ///     elif (
  ///             http_content_type in text_content_types
  ///             or (
  ///                     http_content_type.startswith('text/')
  ///                     and http_content_type.endswith('+xml')
  ///             )
  ///     ):
  ///         acceptable_content_type = 1
  ///         rfc3023_encoding = http_encoding or 'us-ascii'
  ///     elif http_content_type.startswith('text/'):
  ///         rfc3023_encoding = http_encoding or 'us-ascii'
  ///     elif http_headers and 'content-type' not in http_headers:
  ///         rfc3023_encoding = xml_encoding or 'iso-8859-1'
  ///     else:
  ///         rfc3023_encoding = xml_encoding or 'utf-8'
  ///     # gb18030 is a superset of gb2312, so always replace gb2312
  ///     # with gb18030 for greater compatibility.
  ///     if rfc3023_encoding.lower() == 'gb2312':
  ///         rfc3023_encoding = 'gb18030'
  ///     if xml_encoding.lower() == 'gb2312':
  ///         xml_encoding = 'gb18030'
  ///
  ///     # there are four encodings to keep track of:
  ///     # - http_encoding is the encoding declared in the Content-Type HTTP header
  ///     # - xml_encoding is the encoding declared in the <?xml declaration
  ///     # - bom_encoding is the encoding sniffed from the first 4 bytes of the XML data
  ///     # - rfc3023_encoding is the actual encoding, as per RFC 3023 and a variety of other conflicting specifications
  ///     error = None
  ///
  ///     if http_headers and (not acceptable_content_type):
  ///         if 'content-type' in http_headers:
  ///             msg = '%s is not an XML media type' % http_headers['content-type']
  ///         else:
  ///             msg = 'no Content-type specified'
  ///         error = NonXMLContentType(msg)
  ///
  ///     # determine character encoding
  ///     known_encoding = 0
  ///     tried_encodings = []
  ///     # try: HTTP encoding, declared XML encoding, encoding sniffed from BOM
  ///     for proposed_encoding in (rfc3023_encoding, xml_encoding, bom_encoding,
  ///                               lazy_chardet_encoding, 'utf-8', 'windows-1252', 'iso-8859-2'):
  ///         if callable(proposed_encoding):
  ///             proposed_encoding = proposed_encoding(data)
  ///         if not proposed_encoding:
  ///             continue
  ///         if proposed_encoding in tried_encodings:
  ///             continue
  ///         tried_encodings.append(proposed_encoding)
  ///         try:
  ///             data = data.decode(proposed_encoding)
  ///         except (UnicodeDecodeError, LookupError):
  ///             pass
  ///         else:
  ///             known_encoding = 1
  ///             # Update the encoding in the opening XML processing instruction.
  ///             new_declaration = '''<?xml version='1.0' encoding='utf-8'?>'''
  ///             if RE_XML_DECLARATION.search(data):
  ///                 data = RE_XML_DECLARATION.sub(new_declaration, data)
  ///             else:
  ///                 data = new_declaration + '\n' + data
  ///             data = data.encode('utf-8')
  ///             break
  ///     # if still no luck, give up
  ///     if not known_encoding:
  ///         error = CharacterEncodingUnknown(
  ///             'document encoding unknown, I tried ' +
  ///             '%s, %s, utf-8, windows-1252, and iso-8859-2 but nothing worked' %
  ///             (rfc3023_encoding, xml_encoding))
  ///         rfc3023_encoding = ''
  ///     elif proposed_encoding != rfc3023_encoding:
  ///         error = CharacterEncodingOverride(
  ///             'document declared as %s, but parsed as %s' %
  ///             (rfc3023_encoding, proposed_encoding))
  ///         rfc3023_encoding = proposed_encoding
  ///
  ///     result['encoding'] = rfc3023_encoding
  ///     if error:
  ///         result['bozo'] = True
  ///         result['bozo_exception'] = error
  ///     return data
  /// ```
  Object? convert_to_utf8({
    required Object? http_headers,
    required Object? data,
    required Object? result,
  }) =>
      getFunction("convert_to_utf8").call(
        <Object?>[
          http_headers,
          data,
          result,
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

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parse a feed from a URL, file, stream, or string.
  ///
  /// :param url_file_stream_or_string:
  ///     File-like object, URL, file path, or string. Both byte and text strings
  ///     are accepted. If necessary, encoding will be derived from the response
  ///     headers or automatically detected.
  ///
  ///     Note that strings may trigger network I/O or filesystem access
  ///     depending on the value. Wrap an untrusted string in
  ///     a :class:`io.StringIO` or :class:`io.BytesIO` to avoid this. Do not
  ///     pass untrusted strings to this function.
  ///
  ///     When a URL is not passed the feed location to use in relative URL
  ///     resolution should be passed in the ``Content-Location`` response header
  ///     (see ``response_headers`` below).
  ///
  /// :param str etag: HTTP ``ETag`` request header.
  /// :param modified: HTTP ``Last-Modified`` request header.
  /// :type modified: :class:`str`, :class:`time.struct_time` 9-tuple, or
  ///     :class:`datetime.datetime`
  /// :param str agent: HTTP ``User-Agent`` request header, which defaults to
  ///     the value of :data:`feedparser.USER_AGENT`.
  /// :param referrer: HTTP ``Referer`` [sic] request header.
  /// :param request_headers:
  ///     A mapping of HTTP header name to HTTP header value to add to the
  ///     request, overriding internally generated values.
  /// :type request_headers: :class:`dict` mapping :class:`str` to :class:`str`
  /// :param response_headers:
  ///     A mapping of HTTP header name to HTTP header value. Multiple values may
  ///     be joined with a comma. If a HTTP request was made, these headers
  ///     override any matching headers in the response. Otherwise this specifies
  ///     the entirety of the response headers.
  /// :type response_headers: :class:`dict` mapping :class:`str` to :class:`str`
  ///
  /// :param bool resolve_relative_uris:
  ///     Should feedparser attempt to resolve relative URIs absolute ones within
  ///     HTML content?  Defaults to the value of
  ///     :data:`feedparser.RESOLVE_RELATIVE_URIS`, which is ``True``.
  /// :param bool sanitize_html:
  ///     Should feedparser skip HTML sanitization? Only disable this if you know
  ///     what you are doing!  Defaults to the value of
  ///     :data:`feedparser.SANITIZE_HTML`, which is ``True``.
  ///
  /// :return: A :class:`FeedParserDict`.
  ///
  /// ### python source
  /// ```py
  /// def parse(url_file_stream_or_string, etag=None, modified=None, agent=None, referrer=None, handlers=None, request_headers=None, response_headers=None, resolve_relative_uris=None, sanitize_html=None):
  ///     """Parse a feed from a URL, file, stream, or string.
  ///
  ///     :param url_file_stream_or_string:
  ///         File-like object, URL, file path, or string. Both byte and text strings
  ///         are accepted. If necessary, encoding will be derived from the response
  ///         headers or automatically detected.
  ///
  ///         Note that strings may trigger network I/O or filesystem access
  ///         depending on the value. Wrap an untrusted string in
  ///         a :class:`io.StringIO` or :class:`io.BytesIO` to avoid this. Do not
  ///         pass untrusted strings to this function.
  ///
  ///         When a URL is not passed the feed location to use in relative URL
  ///         resolution should be passed in the ``Content-Location`` response header
  ///         (see ``response_headers`` below).
  ///
  ///     :param str etag: HTTP ``ETag`` request header.
  ///     :param modified: HTTP ``Last-Modified`` request header.
  ///     :type modified: :class:`str`, :class:`time.struct_time` 9-tuple, or
  ///         :class:`datetime.datetime`
  ///     :param str agent: HTTP ``User-Agent`` request header, which defaults to
  ///         the value of :data:`feedparser.USER_AGENT`.
  ///     :param referrer: HTTP ``Referer`` [sic] request header.
  ///     :param request_headers:
  ///         A mapping of HTTP header name to HTTP header value to add to the
  ///         request, overriding internally generated values.
  ///     :type request_headers: :class:`dict` mapping :class:`str` to :class:`str`
  ///     :param response_headers:
  ///         A mapping of HTTP header name to HTTP header value. Multiple values may
  ///         be joined with a comma. If a HTTP request was made, these headers
  ///         override any matching headers in the response. Otherwise this specifies
  ///         the entirety of the response headers.
  ///     :type response_headers: :class:`dict` mapping :class:`str` to :class:`str`
  ///
  ///     :param bool resolve_relative_uris:
  ///         Should feedparser attempt to resolve relative URIs absolute ones within
  ///         HTML content?  Defaults to the value of
  ///         :data:`feedparser.RESOLVE_RELATIVE_URIS`, which is ``True``.
  ///     :param bool sanitize_html:
  ///         Should feedparser skip HTML sanitization? Only disable this if you know
  ///         what you are doing!  Defaults to the value of
  ///         :data:`feedparser.SANITIZE_HTML`, which is ``True``.
  ///
  ///     :return: A :class:`FeedParserDict`.
  ///     """
  ///
  ///     if not agent or sanitize_html is None or resolve_relative_uris is None:
  ///         import feedparser
  ///     if not agent:
  ///         agent = feedparser.USER_AGENT
  ///     if sanitize_html is None:
  ///         sanitize_html = feedparser.SANITIZE_HTML
  ///     if resolve_relative_uris is None:
  ///         resolve_relative_uris = feedparser.RESOLVE_RELATIVE_URIS
  ///
  ///     result = FeedParserDict(
  ///         bozo=False,
  ///         entries=[],
  ///         feed=FeedParserDict(),
  ///         headers={},
  ///     )
  ///
  ///     try:
  ///         data = _open_resource(url_file_stream_or_string, etag, modified, agent, referrer, handlers, request_headers, result)
  ///     except urllib.error.URLError as error:
  ///         result.update({
  ///             'bozo': True,
  ///             'bozo_exception': error,
  ///         })
  ///         return result
  ///
  ///     if not data:
  ///         return result
  ///
  ///     # overwrite existing headers using response_headers
  ///     result['headers'].update(response_headers or {})
  ///
  ///     data = convert_to_utf8(result['headers'], data, result)
  ///     use_strict_parser = result['encoding'] and True or False
  ///
  ///     result['version'], data, entities = replace_doctype(data)
  ///
  ///     # Ensure that baseuri is an absolute URI using an acceptable URI scheme.
  ///     contentloc = result['headers'].get('content-location', '')
  ///     href = result.get('href', '')
  ///     baseuri = make_safe_absolute_uri(href, contentloc) or make_safe_absolute_uri(contentloc) or href
  ///
  ///     baselang = result['headers'].get('content-language', None)
  ///     if isinstance(baselang, bytes) and baselang is not None:
  ///         baselang = baselang.decode('utf-8', 'ignore')
  ///
  ///     if not _XML_AVAILABLE:
  ///         use_strict_parser = 0
  ///     if use_strict_parser:
  ///         # initialize the SAX parser
  ///         feedparser = StrictFeedParser(baseuri, baselang, 'utf-8')
  ///         feedparser.resolve_relative_uris = resolve_relative_uris
  ///         feedparser.sanitize_html = sanitize_html
  ///         saxparser = xml.sax.make_parser(PREFERRED_XML_PARSERS)
  ///         saxparser.setFeature(xml.sax.handler.feature_namespaces, 1)
  ///         try:
  ///             # disable downloading external doctype references, if possible
  ///             saxparser.setFeature(xml.sax.handler.feature_external_ges, 0)
  ///         except xml.sax.SAXNotSupportedException:
  ///             pass
  ///         saxparser.setContentHandler(feedparser)
  ///         saxparser.setErrorHandler(feedparser)
  ///         source = xml.sax.xmlreader.InputSource()
  ///         source.setByteStream(io.BytesIO(data))
  ///         try:
  ///             saxparser.parse(source)
  ///         except xml.sax.SAXException as e:
  ///             result['bozo'] = 1
  ///             result['bozo_exception'] = feedparser.exc or e
  ///             use_strict_parser = 0
  ///     if not use_strict_parser:
  ///         feedparser = LooseFeedParser(baseuri, baselang, 'utf-8', entities)
  ///         feedparser.resolve_relative_uris = resolve_relative_uris
  ///         feedparser.sanitize_html = sanitize_html
  ///         feedparser.feed(data.decode('utf-8', 'replace'))
  ///     result['feed'] = feedparser.feeddata
  ///     result['entries'] = feedparser.entries
  ///     result['version'] = result['version'] or feedparser.version
  ///     result['namespaces'] = feedparser.namespaces_in_use
  ///     return result
  /// ```
  Object? parse({
    required Object? url_file_stream_or_string,
    Object? etag,
    Object? modified,
    Object? agent,
    Object? referrer,
    Object? handlers,
    Object? request_headers,
    Object? response_headers,
    Object? resolve_relative_uris,
    Object? sanitize_html,
  }) =>
      getFunction("parse").call(
        <Object?>[
          url_file_stream_or_string,
          etag,
          modified,
          agent,
          referrer,
          handlers,
          request_headers,
          response_headers,
          resolve_relative_uris,
          sanitize_html,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## registerDateHandler
  ///
  /// ### python docstring
  ///
  /// Register a date handler function (takes string, returns 9-tuple date in GMT)
  ///
  /// ### python source
  /// ```py
  /// def registerDateHandler(func):
  ///     """Register a date handler function (takes string, returns 9-tuple date in GMT)"""
  ///     _date_handlers.insert(0, func)
  /// ```
  Object? registerDateHandler({
    required Object? func,
  }) =>
      getFunction("registerDateHandler").call(
        <Object?>[
          func,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## replace_doctype
  ///
  /// ### python docstring
  ///
  /// Strips and replaces the DOCTYPE, returns (rss_version, stripped_data)
  ///
  /// rss_version may be 'rss091n' or None
  /// stripped_data is the same XML document with a replaced DOCTYPE
  ///
  /// ### python source
  /// ```py
  /// def replace_doctype(data):
  ///     """Strips and replaces the DOCTYPE, returns (rss_version, stripped_data)
  ///
  ///     rss_version may be 'rss091n' or None
  ///     stripped_data is the same XML document with a replaced DOCTYPE
  ///     """
  ///
  ///     # Divide the document into two groups by finding the location
  ///     # of the first element that doesn't begin with '<?' or '<!'.
  ///     start = re.search(br'<\w', data)
  ///     start = start and start.start() or -1
  ///     head, data = data[:start+1], data[start+1:]
  ///
  ///     # Save and then remove all of the ENTITY declarations.
  ///     entity_results = RE_ENTITY_PATTERN.findall(head)
  ///     head = RE_ENTITY_PATTERN.sub(b'', head)
  ///
  ///     # Find the DOCTYPE declaration and check the feed type.
  ///     doctype_results = RE_DOCTYPE_PATTERN.findall(head)
  ///     doctype = doctype_results and doctype_results[0] or b''
  ///     if b'netscape' in doctype.lower():
  ///         version = 'rss091n'
  ///     else:
  ///         version = None
  ///
  ///     # Re-insert the safe ENTITY declarations if a DOCTYPE was found.
  ///     replacement = b''
  ///     if len(doctype_results) == 1 and entity_results:
  ///         safe_entities = [
  ///             e
  ///             for e in entity_results
  ///             if RE_SAFE_ENTITY_PATTERN.match(e)
  ///         ]
  ///         if safe_entities:
  ///             replacement = b'<!DOCTYPE feed [\n<!ENTITY' \
  ///                         + b'>\n<!ENTITY '.join(safe_entities) \
  ///                         + b'>\n]>'
  ///     data = RE_DOCTYPE_PATTERN.sub(replacement, head) + data
  ///
  ///     # Precompute the safe entities for the loose parser.
  ///     safe_entities = {
  ///         k.decode('utf-8'): v.decode('utf-8')
  ///         for k, v in RE_SAFE_ENTITY_PATTERN.findall(replacement)
  ///     }
  ///     return version, data, safe_entities
  /// ```
  Object? replace_doctype({
    required Object? data,
  }) =>
      getFunction("replace_doctype").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## http
  http get $http => http.import();

  /// ## $mixin
  $mixin get $$mixin => $mixin.import();

  /// ## sgmllib
  ///
  /// ### python docstring
  ///
  /// A parser for SGML, using the derived class as a static DTD.
  sgmllib get $sgmllib => sgmllib.import();

  /// ## attrfind (getter)
  Object? get attrfind => getAttribute("attrfind");

  /// ## attrfind (setter)
  set attrfind(Object? attrfind) => setAttribute("attrfind", attrfind);

  /// ## charref (getter)
  Object? get charref => getAttribute("charref");

  /// ## charref (setter)
  set charref(Object? charref) => setAttribute("charref", charref);

  /// ## endbracket (getter)
  Object? get endbracket => getAttribute("endbracket");

  /// ## endbracket (setter)
  set endbracket(Object? endbracket) => setAttribute("endbracket", endbracket);

  /// ## entityref (getter)
  Object? get entityref => getAttribute("entityref");

  /// ## entityref (setter)
  set entityref(Object? entityref) => setAttribute("entityref", entityref);

  /// ## incomplete (getter)
  Object? get incomplete => getAttribute("incomplete");

  /// ## incomplete (setter)
  set incomplete(Object? incomplete) => setAttribute("incomplete", incomplete);

  /// ## interesting (getter)
  Object? get interesting => getAttribute("interesting");

  /// ## interesting (setter)
  set interesting(Object? interesting) =>
      setAttribute("interesting", interesting);

  /// ## shorttag (getter)
  Object? get shorttag => getAttribute("shorttag");

  /// ## shorttag (setter)
  set shorttag(Object? shorttag) => setAttribute("shorttag", shorttag);

  /// ## shorttagopen (getter)
  Object? get shorttagopen => getAttribute("shorttagopen");

  /// ## shorttagopen (setter)
  set shorttagopen(Object? shorttagopen) =>
      setAttribute("shorttagopen", shorttagopen);

  /// ## starttagopen (getter)
  Object? get starttagopen => getAttribute("starttagopen");

  /// ## starttagopen (setter)
  set starttagopen(Object? starttagopen) =>
      setAttribute("starttagopen", starttagopen);

  /// ## tagfind (getter)
  Object? get tagfind => getAttribute("tagfind");

  /// ## tagfind (setter)
  set tagfind(Object? tagfind) => setAttribute("tagfind", tagfind);

  /// ## PREFERRED_XML_PARSERS (getter)
  Object? get PREFERRED_XML_PARSERS => getAttribute("PREFERRED_XML_PARSERS");

  /// ## PREFERRED_XML_PARSERS (setter)
  set PREFERRED_XML_PARSERS(Object? PREFERRED_XML_PARSERS) =>
      setAttribute("PREFERRED_XML_PARSERS", PREFERRED_XML_PARSERS);

  /// ## SUPPORTED_VERSIONS (getter)
  Object? get SUPPORTED_VERSIONS => getAttribute("SUPPORTED_VERSIONS");

  /// ## SUPPORTED_VERSIONS (setter)
  set SUPPORTED_VERSIONS(Object? SUPPORTED_VERSIONS) =>
      setAttribute("SUPPORTED_VERSIONS", SUPPORTED_VERSIONS);
}

/// ## http
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
/// import base64
/// import datetime
/// import gzip
/// import io
/// import re
/// import struct
/// import urllib.parse
/// import urllib.request
/// import zlib
///
/// from .datetimes import _parse_date
/// from .urls import convert_to_idn
///
///
/// # HTTP "Accept" header to send to servers when downloading feeds.  If you don't
/// # want to send an Accept header, set this to None.
/// ACCEPT_HEADER = "application/atom+xml,application/rdf+xml,application/rss+xml,application/x-netcdf,application/xml;q=0.9,text/xml;q=0.2,*/*;q=0.1"
///
///
/// class _FeedURLHandler(urllib.request.HTTPDigestAuthHandler, urllib.request.HTTPRedirectHandler, urllib.request.HTTPDefaultErrorHandler):
///     def http_error_default(self, req, fp, code, msg, headers):
///         # The default implementation just raises HTTPError.
///         # Forget that.
///         fp.status = code
///         return fp
///
///     def http_error_301(self, req, fp, code, msg, hdrs):
///         result = urllib.request.HTTPRedirectHandler.http_error_301(self, req, fp, code, msg, hdrs)
///         if not result:
///             return fp
///         result.status = code
///         result.newurl = result.geturl()
///         return result
///
///     # The default implementations in urllib.request.HTTPRedirectHandler
///     # are identical, so hardcoding a http_error_301 call above
///     # won't affect anything
///     http_error_300 = http_error_301
///     http_error_302 = http_error_301
///     http_error_303 = http_error_301
///     http_error_307 = http_error_301
///
///     def http_error_401(self, req, fp, code, msg, headers):
///         # Check if
///         # - server requires digest auth, AND
///         # - we tried (unsuccessfully) with basic auth, AND
///         # If all conditions hold, parse authentication information
///         # out of the Authorization header we sent the first time
///         # (for the username and password) and the WWW-Authenticate
///         # header the server sent back (for the realm) and retry
///         # the request with the appropriate digest auth headers instead.
///         # This evil genius hack has been brought to you by Aaron Swartz.
///         host = urllib.parse.urlparse(req.get_full_url())[1]
///         if 'Authorization' not in req.headers or 'WWW-Authenticate' not in headers:
///             return self.http_error_default(req, fp, code, msg, headers)
///         auth = base64.decodebytes(req.headers['Authorization'].split(' ')[1].encode()).decode()
///         user, passw = auth.split(':')
///         realm = re.findall('realm="([^"]*)"', headers['WWW-Authenticate'])[0]
///         self.add_password(realm, host, user, passw)
///         retry = self.http_error_auth_reqed('www-authenticate', host, req, headers)
///         self.reset_retry_count()
///         return retry
///
///
/// def _build_urllib2_request(url, agent, accept_header, etag, modified, referrer, auth, request_headers):
///     request = urllib.request.Request(url)
///     request.add_header('User-Agent', agent)
///     if etag:
///         request.add_header('If-None-Match', etag)
///     if isinstance(modified, str):
///         modified = _parse_date(modified)
///     elif isinstance(modified, datetime.datetime):
///         modified = modified.utctimetuple()
///     if modified:
///         # format into an RFC 1123-compliant timestamp. We can't use
///         # time.strftime() since the %a and %b directives can be affected
///         # by the current locale, but RFC 2616 states that dates must be
///         # in English.
///         short_weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
///         months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
///         request.add_header('If-Modified-Since', '%s, %02d %s %04d %02d:%02d:%02d GMT' % (short_weekdays[modified[6]], modified[2], months[modified[1] - 1], modified[0], modified[3], modified[4], modified[5]))
///     if referrer:
///         request.add_header('Referer', referrer)
///     request.add_header('Accept-encoding', 'gzip, deflate')
///     if auth:
///         request.add_header('Authorization', 'Basic %s' % auth)
///     if accept_header:
///         request.add_header('Accept', accept_header)
///     # use this for whatever -- cookies, special headers, etc
///     # [('Cookie','Something'),('x-special-header','Another Value')]
///     for header_name, header_value in request_headers.items():
///         request.add_header(header_name, header_value)
///     request.add_header('A-IM', 'feed')  # RFC 3229 support
///     return request
///
///
/// def get(url, etag=None, modified=None, agent=None, referrer=None, handlers=None, request_headers=None, result=None):
///     if handlers is None:
///         handlers = []
///     elif not isinstance(handlers, list):
///         handlers = [handlers]
///     if request_headers is None:
///         request_headers = {}
///
///     # Deal with the feed URI scheme
///     if url.startswith('feed:http'):
///         url = url[5:]
///     elif url.startswith('feed:'):
///         url = 'http:' + url[5:]
///     if not agent:
///         from . import USER_AGENT
///         agent = USER_AGENT
///     # Test for inline user:password credentials for HTTP basic auth
///     auth = None
///     if not url.startswith('ftp:'):
///         url_pieces = urllib.parse.urlparse(url)
///         if url_pieces.username:
///             new_pieces = list(url_pieces)
///             new_pieces[1] = url_pieces.hostname
///             if url_pieces.port:
///                 new_pieces[1] = f'{url_pieces.hostname}:{url_pieces.port}'
///             url = urllib.parse.urlunparse(new_pieces)
///             auth = base64.standard_b64encode(f'{url_pieces.username}:{url_pieces.password}'.encode()).decode()
///
///     # iri support
///     if not isinstance(url, bytes):
///         url = convert_to_idn(url)
///
///     # Prevent UnicodeEncodeErrors caused by Unicode characters in the path.
///     bits = []
///     for c in url:
///         try:
///             c.encode('ascii')
///         except UnicodeEncodeError:
///             bits.append(urllib.parse.quote(c))
///         else:
///             bits.append(c)
///     url = ''.join(bits)
///
///     # try to open with urllib2 (to use optional headers)
///     request = _build_urllib2_request(url, agent, ACCEPT_HEADER, etag, modified, referrer, auth, request_headers)
///     opener = urllib.request.build_opener(*tuple(handlers + [_FeedURLHandler()]))
///     opener.addheaders = []  # RMK - must clear so we only send our custom User-Agent
///     f = opener.open(request)
///     data = f.read()
///     f.close()
///
///     # lowercase all of the HTTP headers for comparisons per RFC 2616
///     result['headers'] = {k.lower(): v for k, v in f.headers.items()}
///
///     # if feed is gzip-compressed, decompress it
///     if data and 'gzip' in result['headers'].get('content-encoding', ''):
///         try:
///             data = gzip.GzipFile(fileobj=io.BytesIO(data)).read()
///         except (EOFError, IOError, struct.error) as e:
///             # IOError can occur if the gzip header is bad.
///             # struct.error can occur if the data is damaged.
///             result['bozo'] = True
///             result['bozo_exception'] = e
///             if isinstance(e, struct.error):
///                 # A gzip header was found but the data is corrupt.
///                 # Ideally, we should re-request the feed without the
///                 # 'Accept-encoding: gzip' header, but we don't.
///                 data = None
///     elif data and 'deflate' in result['headers'].get('content-encoding', ''):
///         try:
///             data = zlib.decompress(data)
///         except zlib.error:
///             try:
///                 # The data may have no headers and no checksum.
///                 data = zlib.decompress(data, -15)
///             except zlib.error as e:
///                 result['bozo'] = True
///                 result['bozo_exception'] = e
///
///     # save HTTP headers
///     if 'etag' in result['headers']:
///         etag = result['headers'].get('etag', '')
///         if isinstance(etag, bytes):
///             etag = etag.decode('utf-8', 'ignore')
///         if etag:
///             result['etag'] = etag
///     if 'last-modified' in result['headers']:
///         modified = result['headers'].get('last-modified', '')
///         if modified:
///             result['modified'] = modified
///             result['modified_parsed'] = _parse_date(modified)
///     if isinstance(f.url, bytes):
///         result['href'] = f.url.decode('utf-8', 'ignore')
///     else:
///         result['href'] = f.url
///     result['status'] = getattr(f, 'status', None) or 200
///
///     # Stop processing if the server sent HTTP 304 Not Modified.
///     if getattr(f, 'code', 0) == 304:
///         result['version'] = ''
///         result['debug_message'] = 'The feed has not changed since you last checked, ' + \
///             'so the server sent no data.  This is a feature, not a bug!'
///
///     return data
/// ```
final class http extends PythonModule {
  http.from(super.pythonModule) : super.from();

  static http import() => PythonFfiDart.instance.importModule(
        "feedparser.http",
        http.from,
      );

  /// ## ACCEPT_HEADER (getter)
  Object? get ACCEPT_HEADER => getAttribute("ACCEPT_HEADER");

  /// ## ACCEPT_HEADER (setter)
  set ACCEPT_HEADER(Object? ACCEPT_HEADER) =>
      setAttribute("ACCEPT_HEADER", ACCEPT_HEADER);
}

/// ## zlib
final class zlib extends PythonModule {
  zlib.from(super.pythonModule) : super.from();

  static zlib import() => PythonFfiDart.instance.importModule(
        "feedparser.zlib",
        zlib.from,
      );

  /// ## DEFLATED (getter)
  Object? get DEFLATED => getAttribute("DEFLATED");

  /// ## DEFLATED (setter)
  set DEFLATED(Object? DEFLATED) => setAttribute("DEFLATED", DEFLATED);

  /// ## DEF_BUF_SIZE (getter)
  Object? get DEF_BUF_SIZE => getAttribute("DEF_BUF_SIZE");

  /// ## DEF_BUF_SIZE (setter)
  set DEF_BUF_SIZE(Object? DEF_BUF_SIZE) =>
      setAttribute("DEF_BUF_SIZE", DEF_BUF_SIZE);

  /// ## DEF_MEM_LEVEL (getter)
  Object? get DEF_MEM_LEVEL => getAttribute("DEF_MEM_LEVEL");

  /// ## DEF_MEM_LEVEL (setter)
  set DEF_MEM_LEVEL(Object? DEF_MEM_LEVEL) =>
      setAttribute("DEF_MEM_LEVEL", DEF_MEM_LEVEL);

  /// ## MAX_WBITS (getter)
  Object? get MAX_WBITS => getAttribute("MAX_WBITS");

  /// ## MAX_WBITS (setter)
  set MAX_WBITS(Object? MAX_WBITS) => setAttribute("MAX_WBITS", MAX_WBITS);

  /// ## ZLIB_RUNTIME_VERSION (getter)
  Object? get ZLIB_RUNTIME_VERSION => getAttribute("ZLIB_RUNTIME_VERSION");

  /// ## ZLIB_RUNTIME_VERSION (setter)
  set ZLIB_RUNTIME_VERSION(Object? ZLIB_RUNTIME_VERSION) =>
      setAttribute("ZLIB_RUNTIME_VERSION", ZLIB_RUNTIME_VERSION);

  /// ## ZLIB_VERSION (getter)
  Object? get ZLIB_VERSION => getAttribute("ZLIB_VERSION");

  /// ## ZLIB_VERSION (setter)
  set ZLIB_VERSION(Object? ZLIB_VERSION) =>
      setAttribute("ZLIB_VERSION", ZLIB_VERSION);

  /// ## Z_BEST_COMPRESSION (getter)
  Object? get Z_BEST_COMPRESSION => getAttribute("Z_BEST_COMPRESSION");

  /// ## Z_BEST_COMPRESSION (setter)
  set Z_BEST_COMPRESSION(Object? Z_BEST_COMPRESSION) =>
      setAttribute("Z_BEST_COMPRESSION", Z_BEST_COMPRESSION);

  /// ## Z_BEST_SPEED (getter)
  Object? get Z_BEST_SPEED => getAttribute("Z_BEST_SPEED");

  /// ## Z_BEST_SPEED (setter)
  set Z_BEST_SPEED(Object? Z_BEST_SPEED) =>
      setAttribute("Z_BEST_SPEED", Z_BEST_SPEED);

  /// ## Z_BLOCK (getter)
  Object? get Z_BLOCK => getAttribute("Z_BLOCK");

  /// ## Z_BLOCK (setter)
  set Z_BLOCK(Object? Z_BLOCK) => setAttribute("Z_BLOCK", Z_BLOCK);

  /// ## Z_DEFAULT_COMPRESSION (getter)
  Object? get Z_DEFAULT_COMPRESSION => getAttribute("Z_DEFAULT_COMPRESSION");

  /// ## Z_DEFAULT_COMPRESSION (setter)
  set Z_DEFAULT_COMPRESSION(Object? Z_DEFAULT_COMPRESSION) =>
      setAttribute("Z_DEFAULT_COMPRESSION", Z_DEFAULT_COMPRESSION);

  /// ## Z_DEFAULT_STRATEGY (getter)
  Object? get Z_DEFAULT_STRATEGY => getAttribute("Z_DEFAULT_STRATEGY");

  /// ## Z_DEFAULT_STRATEGY (setter)
  set Z_DEFAULT_STRATEGY(Object? Z_DEFAULT_STRATEGY) =>
      setAttribute("Z_DEFAULT_STRATEGY", Z_DEFAULT_STRATEGY);

  /// ## Z_FILTERED (getter)
  Object? get Z_FILTERED => getAttribute("Z_FILTERED");

  /// ## Z_FILTERED (setter)
  set Z_FILTERED(Object? Z_FILTERED) => setAttribute("Z_FILTERED", Z_FILTERED);

  /// ## Z_FINISH (getter)
  Object? get Z_FINISH => getAttribute("Z_FINISH");

  /// ## Z_FINISH (setter)
  set Z_FINISH(Object? Z_FINISH) => setAttribute("Z_FINISH", Z_FINISH);

  /// ## Z_FIXED (getter)
  Object? get Z_FIXED => getAttribute("Z_FIXED");

  /// ## Z_FIXED (setter)
  set Z_FIXED(Object? Z_FIXED) => setAttribute("Z_FIXED", Z_FIXED);

  /// ## Z_FULL_FLUSH (getter)
  Object? get Z_FULL_FLUSH => getAttribute("Z_FULL_FLUSH");

  /// ## Z_FULL_FLUSH (setter)
  set Z_FULL_FLUSH(Object? Z_FULL_FLUSH) =>
      setAttribute("Z_FULL_FLUSH", Z_FULL_FLUSH);

  /// ## Z_HUFFMAN_ONLY (getter)
  Object? get Z_HUFFMAN_ONLY => getAttribute("Z_HUFFMAN_ONLY");

  /// ## Z_HUFFMAN_ONLY (setter)
  set Z_HUFFMAN_ONLY(Object? Z_HUFFMAN_ONLY) =>
      setAttribute("Z_HUFFMAN_ONLY", Z_HUFFMAN_ONLY);

  /// ## Z_NO_COMPRESSION (getter)
  Object? get Z_NO_COMPRESSION => getAttribute("Z_NO_COMPRESSION");

  /// ## Z_NO_COMPRESSION (setter)
  set Z_NO_COMPRESSION(Object? Z_NO_COMPRESSION) =>
      setAttribute("Z_NO_COMPRESSION", Z_NO_COMPRESSION);

  /// ## Z_NO_FLUSH (getter)
  Object? get Z_NO_FLUSH => getAttribute("Z_NO_FLUSH");

  /// ## Z_NO_FLUSH (setter)
  set Z_NO_FLUSH(Object? Z_NO_FLUSH) => setAttribute("Z_NO_FLUSH", Z_NO_FLUSH);

  /// ## Z_PARTIAL_FLUSH (getter)
  Object? get Z_PARTIAL_FLUSH => getAttribute("Z_PARTIAL_FLUSH");

  /// ## Z_PARTIAL_FLUSH (setter)
  set Z_PARTIAL_FLUSH(Object? Z_PARTIAL_FLUSH) =>
      setAttribute("Z_PARTIAL_FLUSH", Z_PARTIAL_FLUSH);

  /// ## Z_RLE (getter)
  Object? get Z_RLE => getAttribute("Z_RLE");

  /// ## Z_RLE (setter)
  set Z_RLE(Object? Z_RLE) => setAttribute("Z_RLE", Z_RLE);

  /// ## Z_SYNC_FLUSH (getter)
  Object? get Z_SYNC_FLUSH => getAttribute("Z_SYNC_FLUSH");

  /// ## Z_SYNC_FLUSH (setter)
  set Z_SYNC_FLUSH(Object? Z_SYNC_FLUSH) =>
      setAttribute("Z_SYNC_FLUSH", Z_SYNC_FLUSH);

  /// ## Z_TREES (getter)
  Object? get Z_TREES => getAttribute("Z_TREES");

  /// ## Z_TREES (setter)
  set Z_TREES(Object? Z_TREES) => setAttribute("Z_TREES", Z_TREES);
}

/// ## mixin
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
/// import base64
/// import binascii
/// import copy
/// import html.entities
/// import re
/// import xml.sax.saxutils
///
/// from .html import _cp1252
/// from .namespaces import _base, cc, dc, georss, itunes, mediarss, psc
/// from .sanitizer import _sanitize_html, _HTMLSanitizer
/// from .util import FeedParserDict
/// from .urls import _urljoin, make_safe_absolute_uri, resolve_relative_uris
///
///
/// class _FeedParserMixin(
///         _base.Namespace,
///         cc.Namespace,
///         dc.Namespace,
///         georss.Namespace,
///         itunes.Namespace,
///         mediarss.Namespace,
///         psc.Namespace,
/// ):
///     namespaces = {
///         '': '',
///         'http://backend.userland.com/rss': '',
///         'http://blogs.law.harvard.edu/tech/rss': '',
///         'http://purl.org/rss/1.0/': '',
///         'http://my.netscape.com/rdf/simple/0.9/': '',
///         'http://example.com/newformat#': '',
///         'http://example.com/necho': '',
///         'http://purl.org/echo/': '',
///         'uri/of/echo/namespace#': '',
///         'http://purl.org/pie/': '',
///         'http://purl.org/atom/ns#': '',
///         'http://www.w3.org/2005/Atom': '',
///         'http://purl.org/rss/1.0/modules/rss091#': '',
///
///         'http://webns.net/mvcb/':                                'admin',
///         'http://purl.org/rss/1.0/modules/aggregation/':          'ag',
///         'http://purl.org/rss/1.0/modules/annotate/':             'annotate',
///         'http://media.tangent.org/rss/1.0/':                     'audio',
///         'http://backend.userland.com/blogChannelModule':         'blogChannel',
///         'http://creativecommons.org/ns#license':                 'cc',
///         'http://web.resource.org/cc/':                           'cc',
///         'http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html': 'creativeCommons',
///         'http://backend.userland.com/creativeCommonsRssModule':  'creativeCommons',
///         'http://purl.org/rss/1.0/modules/company':               'co',
///         'http://purl.org/rss/1.0/modules/content/':              'content',
///         'http://my.theinfo.org/changed/1.0/rss/':                'cp',
///         'http://purl.org/dc/elements/1.1/':                      'dc',
///         'http://purl.org/dc/terms/':                             'dcterms',
///         'http://purl.org/rss/1.0/modules/email/':                'email',
///         'http://purl.org/rss/1.0/modules/event/':                'ev',
///         'http://rssnamespace.org/feedburner/ext/1.0':            'feedburner',
///         'http://freshmeat.net/rss/fm/':                          'fm',
///         'http://xmlns.com/foaf/0.1/':                            'foaf',
///         'http://www.w3.org/2003/01/geo/wgs84_pos#':              'geo',
///         'http://www.georss.org/georss':                          'georss',
///         'http://www.opengis.net/gml':                            'gml',
///         'http://postneo.com/icbm/':                              'icbm',
///         'http://purl.org/rss/1.0/modules/image/':                'image',
///         'http://www.itunes.com/DTDs/PodCast-1.0.dtd':            'itunes',
///         'http://example.com/DTDs/PodCast-1.0.dtd':               'itunes',
///         'http://purl.org/rss/1.0/modules/link/':                 'l',
///         'http://search.yahoo.com/mrss':                          'media',
///         # Version 1.1.2 of the Media RSS spec added the trailing slash on the namespace
///         'http://search.yahoo.com/mrss/':                         'media',
///         'http://madskills.com/public/xml/rss/module/pingback/':  'pingback',
///         'http://prismstandard.org/namespaces/1.2/basic/':        'prism',
///         'http://www.w3.org/1999/02/22-rdf-syntax-ns#':           'rdf',
///         'http://www.w3.org/2000/01/rdf-schema#':                 'rdfs',
///         'http://purl.org/rss/1.0/modules/reference/':            'ref',
///         'http://purl.org/rss/1.0/modules/richequiv/':            'reqv',
///         'http://purl.org/rss/1.0/modules/search/':               'search',
///         'http://purl.org/rss/1.0/modules/slash/':                'slash',
///         'http://schemas.xmlsoap.org/soap/envelope/':             'soap',
///         'http://purl.org/rss/1.0/modules/servicestatus/':        'ss',
///         'http://hacks.benhammersley.com/rss/streaming/':         'str',
///         'http://purl.org/rss/1.0/modules/subscription/':         'sub',
///         'http://purl.org/rss/1.0/modules/syndication/':          'sy',
///         'http://schemas.pocketsoap.com/rss/myDescModule/':       'szf',
///         'http://purl.org/rss/1.0/modules/taxonomy/':             'taxo',
///         'http://purl.org/rss/1.0/modules/threading/':            'thr',
///         'http://purl.org/rss/1.0/modules/textinput/':            'ti',
///         'http://madskills.com/public/xml/rss/module/trackback/': 'trackback',
///         'http://wellformedweb.org/commentAPI/':                  'wfw',
///         'http://purl.org/rss/1.0/modules/wiki/':                 'wiki',
///         'http://www.w3.org/1999/xhtml':                          'xhtml',
///         'http://www.w3.org/1999/xlink':                          'xlink',
///         'http://www.w3.org/XML/1998/namespace':                  'xml',
///         'http://podlove.org/simple-chapters':                    'psc',
///     }
///     _matchnamespaces = {}
///
///     can_be_relative_uri = {
///         'comments',
///         'docs',
///         'href',
///         'icon',
///         'id',
///         'link',
///         'logo',
///         'url',
///         'wfw_comment',
///         'wfw_commentrss',
///     }
///
///     can_contain_relative_uris = {
///         'content',
///         'copyright',
///         'description',
///         'info',
///         'rights',
///         'subtitle',
///         'summary',
///         'tagline',
///         'title',
///     }
///
///     can_contain_dangerous_markup = {
///         'content',
///         'copyright',
///         'description',
///         'info',
///         'rights',
///         'subtitle',
///         'summary',
///         'tagline',
///         'title',
///     }
///
///     html_types = {
///         'application/xhtml+xml',
///         'text/html',
///     }
///
///     def __init__(self):
///         if not self._matchnamespaces:
///             for k, v in self.namespaces.items():
///                 self._matchnamespaces[k.lower()] = v
///         self.feeddata = FeedParserDict()  # feed-level data
///         self.entries = []  # list of entry-level data
///         self.version = ''  # feed type/version, see SUPPORTED_VERSIONS
///         self.namespaces_in_use = {}  # dictionary of namespaces defined by the feed
///
///         # the following are used internally to track state;
///         # this is really out of control and should be refactored
///         self.infeed = 0
///         self.inentry = 0
///         self.incontent = 0
///         self.intextinput = 0
///         self.inimage = 0
///         self.inauthor = 0
///         self.incontributor = 0
///         self.inpublisher = 0
///         self.insource = 0
///
///         self.sourcedata = FeedParserDict()
///         self.contentparams = FeedParserDict()
///         self._summaryKey = None
///         self.namespacemap = {}
///         self.elementstack = []
///         self.basestack = []
///         self.langstack = []
///         self.svgOK = 0
///         self.title_depth = -1
///         self.depth = 0
///         self.hasContent = 0
///         if self.lang:
///             self.feeddata['language'] = self.lang.replace('_', '-')
///
///         # A map of the following form:
///         #     {
///         #         object_that_value_is_set_on: {
///         #             property_name: depth_of_node_property_was_extracted_from,
///         #             other_property: depth_of_node_property_was_extracted_from,
///         #         },
///         #     }
///         self.property_depth_map = {}
///         super(_FeedParserMixin, self).__init__()
///
///     def _normalize_attributes(self, kv):
///         raise NotImplementedError
///
///     def unknown_starttag(self, tag, attrs):
///         # increment depth counter
///         self.depth += 1
///
///         # normalize attrs
///         attrs = [self._normalize_attributes(attr) for attr in attrs]
///
///         # track xml:base and xml:lang
///         attrs_d = dict(attrs)
///         baseuri = attrs_d.get('xml:base', attrs_d.get('base')) or self.baseuri
///         if isinstance(baseuri, bytes):
///             baseuri = baseuri.decode(self.encoding, 'ignore')
///         # ensure that self.baseuri is always an absolute URI that
///         # uses a whitelisted URI scheme (e.g. not `javscript:`)
///         if self.baseuri:
///             self.baseuri = make_safe_absolute_uri(self.baseuri, baseuri) or self.baseuri
///         else:
///             self.baseuri = _urljoin(self.baseuri, baseuri)
///         lang = attrs_d.get('xml:lang', attrs_d.get('lang'))
///         if lang == '':
///             # xml:lang could be explicitly set to '', we need to capture that
///             lang = None
///         elif lang is None:
///             # if no xml:lang is specified, use parent lang
///             lang = self.lang
///         if lang:
///             if tag in ('feed', 'rss', 'rdf:RDF'):
///                 self.feeddata['language'] = lang.replace('_', '-')
///         self.lang = lang
///         self.basestack.append(self.baseuri)
///         self.langstack.append(lang)
///
///         # track namespaces
///         for prefix, uri in attrs:
///             if prefix.startswith('xmlns:'):
///                 self.track_namespace(prefix[6:], uri)
///             elif prefix == 'xmlns':
///                 self.track_namespace(None, uri)
///
///         # track inline content
///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
///             if tag in ('xhtml:div', 'div'):
///                 return  # typepad does this 10/2007
///             # element declared itself as escaped markup, but it isn't really
///             self.contentparams['type'] = 'application/xhtml+xml'
///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
///             if tag.find(':') != -1:
///                 prefix, tag = tag.split(':', 1)
///                 namespace = self.namespaces_in_use.get(prefix, '')
///                 if tag == 'math' and namespace == 'http://www.w3.org/1998/Math/MathML':
///                     attrs.append(('xmlns', namespace))
///                 if tag == 'svg' and namespace == 'http://www.w3.org/2000/svg':
///                     attrs.append(('xmlns', namespace))
///             if tag == 'svg':
///                 self.svgOK += 1
///             return self.handle_data('<%s%s>' % (tag, self.strattrs(attrs)), escape=0)
///
///         # match namespaces
///         if tag.find(':') != -1:
///             prefix, suffix = tag.split(':', 1)
///         else:
///             prefix, suffix = '', tag
///         prefix = self.namespacemap.get(prefix, prefix)
///         if prefix:
///             prefix = prefix + '_'
///
///         # Special hack for better tracking of empty textinput/image elements in
///         # illformed feeds.
///         if (not prefix) and tag not in ('title', 'link', 'description', 'name'):
///             self.intextinput = 0
///         if (not prefix) and tag not in ('title', 'link', 'description', 'url', 'href', 'width', 'height'):
///             self.inimage = 0
///
///         # call special handler (if defined) or default handler
///         methodname = '_start_' + prefix + suffix
///         try:
///             method = getattr(self, methodname)
///             return method(attrs_d)
///         except AttributeError:
///             # Since there's no handler or something has gone wrong we
///             # explicitly add the element and its attributes.
///             unknown_tag = prefix + suffix
///             if len(attrs_d) == 0:
///                 # No attributes so merge it into the enclosing dictionary
///                 return self.push(unknown_tag, 1)
///             else:
///                 # Has attributes so create it in its own dictionary
///                 context = self._get_context()
///                 context[unknown_tag] = attrs_d
///
///     def unknown_endtag(self, tag):
///         # match namespaces
///         if tag.find(':') != -1:
///             prefix, suffix = tag.split(':', 1)
///         else:
///             prefix, suffix = '', tag
///         prefix = self.namespacemap.get(prefix, prefix)
///         if prefix:
///             prefix = prefix + '_'
///         if suffix == 'svg' and self.svgOK:
///             self.svgOK -= 1
///
///         # call special handler (if defined) or default handler
///         methodname = '_end_' + prefix + suffix
///         try:
///             if self.svgOK:
///                 raise AttributeError()
///             method = getattr(self, methodname)
///             method()
///         except AttributeError:
///             self.pop(prefix + suffix)
///
///         # track inline content
///         if self.incontent and not self.contentparams.get('type', 'xml').endswith('xml'):
///             # element declared itself as escaped markup, but it isn't really
///             if tag in ('xhtml:div', 'div'):
///                 return  # typepad does this 10/2007
///             self.contentparams['type'] = 'application/xhtml+xml'
///         if self.incontent and self.contentparams.get('type') == 'application/xhtml+xml':
///             tag = tag.split(':')[-1]
///             self.handle_data('</%s>' % tag, escape=0)
///
///         # track xml:base and xml:lang going out of scope
///         if self.basestack:
///             self.basestack.pop()
///             if self.basestack and self.basestack[-1]:
///                 self.baseuri = self.basestack[-1]
///         if self.langstack:
///             self.langstack.pop()
///             if self.langstack:  # and (self.langstack[-1] is not None):
///                 self.lang = self.langstack[-1]
///
///         self.depth -= 1
///
///     def handle_charref(self, ref):
///         # Called for each character reference, e.g. for '&#160;', ref is '160'
///         if not self.elementstack:
///             return
///         ref = ref.lower()
///         if ref in ('34', '38', '39', '60', '62', 'x22', 'x26', 'x27', 'x3c', 'x3e'):
///             text = '&#%s;' % ref
///         else:
///             if ref[0] == 'x':
///                 c = int(ref[1:], 16)
///             else:
///                 c = int(ref)
///             text = chr(c).encode('utf-8')
///         self.elementstack[-1][2].append(text)
///
///     def handle_entityref(self, ref):
///         # Called for each entity reference, e.g. for '&copy;', ref is 'copy'
///         if not self.elementstack:
///             return
///         if ref in ('lt', 'gt', 'quot', 'amp', 'apos'):
///             text = '&%s;' % ref
///         elif ref in self.entities:
///             text = self.entities[ref]
///             if text.startswith('&#') and text.endswith(';'):
///                 return self.handle_entityref(text)
///         else:
///             try:
///                 html.entities.name2codepoint[ref]
///             except KeyError:
///                 text = '&%s;' % ref
///             else:
///                 text = chr(html.entities.name2codepoint[ref]).encode('utf-8')
///         self.elementstack[-1][2].append(text)
///
///     def handle_data(self, text, escape=1):
///         # Called for each block of plain text, i.e. outside of any tag and
///         # not containing any character or entity references
///         if not self.elementstack:
///             return
///         if escape and self.contentparams.get('type') == 'application/xhtml+xml':
///             text = xml.sax.saxutils.escape(text)
///         self.elementstack[-1][2].append(text)
///
///     def handle_comment(self, text):
///         # Called for each comment, e.g. <!-- insert message here -->
///         pass
///
///     def handle_pi(self, text):
///         # Called for each processing instruction, e.g. <?instruction>
///         pass
///
///     def handle_decl(self, text):
///         pass
///
///     def parse_declaration(self, i):
///         # Override internal declaration handler to handle CDATA blocks.
///         if self.rawdata[i:i+9] == '<![CDATA[':
///             k = self.rawdata.find(']]>', i)
///             if k == -1:
///                 # CDATA block began but didn't finish
///                 k = len(self.rawdata)
///                 return k
///             self.handle_data(xml.sax.saxutils.escape(self.rawdata[i+9:k]), 0)
///             return k+3
///         else:
///             k = self.rawdata.find('>', i)
///             if k >= 0:
///                 return k+1
///             else:
///                 # We have an incomplete CDATA block.
///                 return k
///
///     @staticmethod
///     def map_content_type(content_type):
///         content_type = content_type.lower()
///         if content_type == 'text' or content_type == 'plain':
///             content_type = 'text/plain'
///         elif content_type == 'html':
///             content_type = 'text/html'
///         elif content_type == 'xhtml':
///             content_type = 'application/xhtml+xml'
///         return content_type
///
///     def track_namespace(self, prefix, uri):
///         loweruri = uri.lower()
///         if not self.version:
///             if (prefix, loweruri) == (None, 'http://my.netscape.com/rdf/simple/0.9/'):
///                 self.version = 'rss090'
///             elif loweruri == 'http://purl.org/rss/1.0/':
///                 self.version = 'rss10'
///             elif loweruri == 'http://www.w3.org/2005/atom':
///                 self.version = 'atom10'
///         if loweruri.find('backend.userland.com/rss') != -1:
///             # match any backend.userland.com namespace
///             uri = 'http://backend.userland.com/rss'
///             loweruri = uri
///         if loweruri in self._matchnamespaces:
///             self.namespacemap[prefix] = self._matchnamespaces[loweruri]
///             self.namespaces_in_use[self._matchnamespaces[loweruri]] = uri
///         else:
///             self.namespaces_in_use[prefix or ''] = uri
///
///     def resolve_uri(self, uri):
///         return _urljoin(self.baseuri or '', uri)
///
///     @staticmethod
///     def decode_entities(element, data):
///         return data
///
///     @staticmethod
///     def strattrs(attrs):
///         return ''.join(
///             ' %s="%s"' % (t[0], xml.sax.saxutils.escape(t[1], {'"': '&quot;'}))
///             for t in attrs
///         )
///
///     def push(self, element, expecting_text):
///         self.elementstack.append([element, expecting_text, []])
///
///     def pop(self, element, strip_whitespace=1):
///         if not self.elementstack:
///             return
///         if self.elementstack[-1][0] != element:
///             return
///
///         element, expecting_text, pieces = self.elementstack.pop()
///
///         # Ensure each piece is a str for Python 3
///         for (i, v) in enumerate(pieces):
///             if isinstance(v, bytes):
///                 pieces[i] = v.decode('utf-8')
///
///         if self.version == 'atom10' and self.contentparams.get('type', 'text') == 'application/xhtml+xml':
///             # remove enclosing child element, but only if it is a <div> and
///             # only if all the remaining content is nested underneath it.
///             # This means that the divs would be retained in the following:
///             #    <div>foo</div><div>bar</div>
///             while pieces and len(pieces) > 1 and not pieces[-1].strip():
///                 del pieces[-1]
///             while pieces and len(pieces) > 1 and not pieces[0].strip():
///                 del pieces[0]
///             if pieces and (pieces[0] == '<div>' or pieces[0].startswith('<div ')) and pieces[-1] == '</div>':
///                 depth = 0
///                 for piece in pieces[:-1]:
///                     if piece.startswith('</'):
///                         depth -= 1
///                         if depth == 0:
///                             break
///                     elif piece.startswith('<') and not piece.endswith('/>'):
///                         depth += 1
///                 else:
///                     pieces = pieces[1:-1]
///
///         output = ''.join(pieces)
///         if strip_whitespace:
///             output = output.strip()
///         if not expecting_text:
///             return output
///
///         # decode base64 content
///         if base64 and self.contentparams.get('base64', 0):
///             try:
///                 output = base64.decodebytes(output.encode('utf8')).decode('utf8')
///             except (binascii.Error, binascii.Incomplete, UnicodeDecodeError):
///                 pass
///
///         # resolve relative URIs
///         if (element in self.can_be_relative_uri) and output:
///             # do not resolve guid elements with isPermalink="false"
///             if not element == 'id' or self.guidislink:
///                 output = self.resolve_uri(output)
///
///         # decode entities within embedded markup
///         if not self.contentparams.get('base64', 0):
///             output = self.decode_entities(element, output)
///
///         # some feed formats require consumers to guess
///         # whether the content is html or plain text
///         if not self.version.startswith('atom') and self.contentparams.get('type') == 'text/plain':
///             if self.looks_like_html(output):
///                 self.contentparams['type'] = 'text/html'
///
///         # remove temporary cruft from contentparams
///         try:
///             del self.contentparams['mode']
///         except KeyError:
///             pass
///         try:
///             del self.contentparams['base64']
///         except KeyError:
///             pass
///
///         is_htmlish = self.map_content_type(self.contentparams.get('type', 'text/html')) in self.html_types
///         # resolve relative URIs within embedded markup
///         if is_htmlish and self.resolve_relative_uris:
///             if element in self.can_contain_relative_uris:
///                 output = resolve_relative_uris(output, self.baseuri, self.encoding, self.contentparams.get('type', 'text/html'))
///
///         # sanitize embedded markup
///         if is_htmlish and self.sanitize_html:
///             if element in self.can_contain_dangerous_markup:
///                 output = _sanitize_html(output, self.encoding, self.contentparams.get('type', 'text/html'))
///
///         if self.encoding and isinstance(output, bytes):
///             output = output.decode(self.encoding, 'ignore')
///
///         # address common error where people take data that is already
///         # utf-8, presume that it is iso-8859-1, and re-encode it.
///         if self.encoding in ('utf-8', 'utf-8_INVALID_PYTHON_3') and not isinstance(output, bytes):
///             try:
///                 output = output.encode('iso-8859-1').decode('utf-8')
///             except (UnicodeEncodeError, UnicodeDecodeError):
///                 pass
///
///         # map win-1252 extensions to the proper code points
///         if not isinstance(output, bytes):
///             output = output.translate(_cp1252)
///
///         # categories/tags/keywords/whatever are handled in _end_category or
///         # _end_tags or _end_itunes_keywords
///         if element in ('category', 'tags', 'itunes_keywords'):
///             return output
///
///         if element == 'title' and -1 < self.title_depth <= self.depth:
///             return output
///
///         # store output in appropriate place(s)
///         if self.inentry and not self.insource:
///             if element == 'content':
///                 self.entries[-1].setdefault(element, [])
///                 contentparams = copy.deepcopy(self.contentparams)
///                 contentparams['value'] = output
///                 self.entries[-1][element].append(contentparams)
///             elif element == 'link':
///                 if not self.inimage:
///                     # query variables in urls in link elements are improperly
///                     # converted from `?a=1&b=2` to `?a=1&b;=2` as if they're
///                     # unhandled character references. fix this special case.
///                     output = output.replace('&amp;', '&')
///                     output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
///                     self.entries[-1][element] = output
///                     if output:
///                         self.entries[-1]['links'][-1]['href'] = output
///             else:
///                 if element == 'description':
///                     element = 'summary'
///                 old_value_depth = self.property_depth_map.setdefault(self.entries[-1], {}).get(element)
///                 if old_value_depth is None or self.depth <= old_value_depth:
///                     self.property_depth_map[self.entries[-1]][element] = self.depth
///                     self.entries[-1][element] = output
///                 if self.incontent:
///                     contentparams = copy.deepcopy(self.contentparams)
///                     contentparams['value'] = output
///                     self.entries[-1][element + '_detail'] = contentparams
///         elif self.infeed or self.insource:  # and (not self.intextinput) and (not self.inimage):
///             context = self._get_context()
///             if element == 'description':
///                 element = 'subtitle'
///             context[element] = output
///             if element == 'link':
///                 # fix query variables; see above for the explanation
///                 output = re.sub("&([A-Za-z0-9_]+);", r"&\g<1>", output)
///                 context[element] = output
///                 context['links'][-1]['href'] = output
///             elif self.incontent:
///                 contentparams = copy.deepcopy(self.contentparams)
///                 contentparams['value'] = output
///                 context[element + '_detail'] = contentparams
///         return output
///
///     def push_content(self, tag, attrs_d, default_content_type, expecting_text):
///         self.incontent += 1
///         if self.lang:
///             self.lang = self.lang.replace('_', '-')
///         self.contentparams = FeedParserDict({
///             'type': self.map_content_type(attrs_d.get('type', default_content_type)),
///             'language': self.lang,
///             'base': self.baseuri})
///         self.contentparams['base64'] = self._is_base64(attrs_d, self.contentparams)
///         self.push(tag, expecting_text)
///
///     def pop_content(self, tag):
///         value = self.pop(tag)
///         self.incontent -= 1
///         self.contentparams.clear()
///         return value
///
///     # a number of elements in a number of RSS variants are nominally plain
///     # text, but this is routinely ignored.  This is an attempt to detect
///     # the most common cases.  As false positives often result in silent
///     # data loss, this function errs on the conservative side.
///     @staticmethod
///     def looks_like_html(s):
///         """
///         :type s: str
///         :rtype: bool
///         """
///
///         # must have a close tag or an entity reference to qualify
///         if not (re.search(r'</(\w+)>', s) or re.search(r'&#?\w+;', s)):
///             return False
///
///         # all tags must be in a restricted subset of valid HTML tags
///         if any((t for t in re.findall(r'</?(\w+)', s) if t.lower() not in _HTMLSanitizer.acceptable_elements)):
///             return False
///
///         # all entities must have been defined as valid HTML entities
///         if any((e for e in re.findall(r'&(\w+);', s) if e not in html.entities.entitydefs)):
///             return False
///
///         return True
///
///     def _map_to_standard_prefix(self, name):
///         colonpos = name.find(':')
///         if colonpos != -1:
///             prefix = name[:colonpos]
///             suffix = name[colonpos+1:]
///             prefix = self.namespacemap.get(prefix, prefix)
///             name = prefix + ':' + suffix
///         return name
///
///     def _get_attribute(self, attrs_d, name):
///         return attrs_d.get(self._map_to_standard_prefix(name))
///
///     def _is_base64(self, attrs_d, contentparams):
///         if attrs_d.get('mode', '') == 'base64':
///             return 1
///         if self.contentparams['type'].startswith('text/'):
///             return 0
///         if self.contentparams['type'].endswith('+xml'):
///             return 0
///         if self.contentparams['type'].endswith('/xml'):
///             return 0
///         return 1
///
///     @staticmethod
///     def _enforce_href(attrs_d):
///         href = attrs_d.get('url', attrs_d.get('uri', attrs_d.get('href', None)))
///         if href:
///             try:
///                 del attrs_d['url']
///             except KeyError:
///                 pass
///             try:
///                 del attrs_d['uri']
///             except KeyError:
///                 pass
///             attrs_d['href'] = href
///         return attrs_d
///
///     def _save(self, key, value, overwrite=False):
///         context = self._get_context()
///         if overwrite:
///             context[key] = value
///         else:
///             context.setdefault(key, value)
///
///     def _get_context(self):
///         if self.insource:
///             context = self.sourcedata
///         elif self.inimage and 'image' in self.feeddata:
///             context = self.feeddata['image']
///         elif self.intextinput:
///             context = self.feeddata['textinput']
///         elif self.inentry:
///             context = self.entries[-1]
///         else:
///             context = self.feeddata
///         return context
///
///     def _save_author(self, key, value, prefix='author'):
///         context = self._get_context()
///         context.setdefault(prefix + '_detail', FeedParserDict())
///         context[prefix + '_detail'][key] = value
///         self._sync_author_detail()
///         context.setdefault('authors', [FeedParserDict()])
///         context['authors'][-1][key] = value
///
///     def _save_contributor(self, key, value):
///         context = self._get_context()
///         context.setdefault('contributors', [FeedParserDict()])
///         context['contributors'][-1][key] = value
///
///     def _sync_author_detail(self, key='author'):
///         context = self._get_context()
///         detail = context.get('%ss' % key, [FeedParserDict()])[-1]
///         if detail:
///             name = detail.get('name')
///             email = detail.get('email')
///             if name and email:
///                 context[key] = '%s (%s)' % (name, email)
///             elif name:
///                 context[key] = name
///             elif email:
///                 context[key] = email
///         else:
///             author, email = context.get(key), None
///             if not author:
///                 return
///             emailmatch = re.search(r'''(([a-zA-Z0-9\_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?))(\?subject=\S+)?''', author)
///             if emailmatch:
///                 email = emailmatch.group(0)
///                 # probably a better way to do the following, but it passes
///                 # all the tests
///                 author = author.replace(email, '')
///                 author = author.replace('()', '')
///                 author = author.replace('<>', '')
///                 author = author.replace('&lt;&gt;', '')
///                 author = author.strip()
///                 if author and (author[0] == '('):
///                     author = author[1:]
///                 if author and (author[-1] == ')'):
///                     author = author[:-1]
///                 author = author.strip()
///             if author or email:
///                 context.setdefault('%s_detail' % key, detail)
///             if author:
///                 detail['name'] = author
///             if email:
///                 detail['email'] = email
///
///     def _add_tag(self, term, scheme, label):
///         context = self._get_context()
///         tags = context.setdefault('tags', [])
///         if (not term) and (not scheme) and (not label):
///             return
///         value = FeedParserDict(term=term, scheme=scheme, label=label)
///         if value not in tags:
///             tags.append(value)
///
///     def _start_tags(self, attrs_d):
///         # This is a completely-made up element. Its semantics are determined
///         # only by a single feed that precipitated bug report 392 on Google Code.
///         # In short, this is junk code.
///         self.push('tags', 1)
///
///     def _end_tags(self):
///         for term in self.pop('tags').split(','):
///             self._add_tag(term.strip(), None, None)
/// ```
final class $mixin extends PythonModule {
  $mixin.from(super.pythonModule) : super.from();

  static $mixin import() => PythonFfiDart.instance.importModule(
        "feedparser.mixin",
        $mixin.from,
      );
}

/// ## binascii
final class binascii extends PythonModule {
  binascii.from(super.pythonModule) : super.from();

  static binascii import() => PythonFfiDart.instance.importModule(
        "feedparser.binascii",
        binascii.from,
      );
}

/// ## cc
///
/// ### python source
/// ```py
/// # Support for the Creative Commons licensing extensions
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
/// from ..util import FeedParserDict
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         # RDF-based namespace
///         'http://creativecommons.org/ns#license': 'cc',
///
///         # Old RDF-based namespace
///         'http://web.resource.org/cc/': 'cc',
///
///         # RSS-based namespace
///         'http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html': 'creativecommons',
///
///         # Old RSS-based namespace
///         'http://backend.userland.com/creativeCommonsRssModule': 'creativecommons',
///     }
///
///     def _start_cc_license(self, attrs_d):
///         context = self._get_context()
///         value = self._get_attribute(attrs_d, 'rdf:resource')
///         attrs_d = FeedParserDict()
///         attrs_d['rel'] = 'license'
///         if value:
///             attrs_d['href'] = value
///         context.setdefault('links', []).append(attrs_d)
///
///     def _start_creativecommons_license(self, attrs_d):
///         self.push('license', 1)
///     _start_creativeCommons_license = _start_creativecommons_license
///
///     def _end_creativecommons_license(self):
///         value = self.pop('license')
///         context = self._get_context()
///         attrs_d = FeedParserDict()
///         attrs_d['rel'] = 'license'
///         if value:
///             attrs_d['href'] = value
///         context.setdefault('links', []).append(attrs_d)
///         del context['license']
///     _end_creativeCommons_license = _end_creativecommons_license
/// ```
final class cc extends PythonModule {
  cc.from(super.pythonModule) : super.from();

  static cc import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.cc",
        cc.from,
      );
}

/// ## dc
///
/// ### python source
/// ```py
/// # Support for the Dublin Core metadata extensions
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
/// from ..datetimes import _parse_date
/// from ..util import FeedParserDict
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         'http://purl.org/dc/elements/1.1/': 'dc',
///         'http://purl.org/dc/terms/': 'dcterms',
///     }
///
///     def _end_dc_author(self):
///         self._end_author()
///
///     def _end_dc_creator(self):
///         self._end_author()
///
///     def _end_dc_date(self):
///         self._end_updated()
///
///     def _end_dc_description(self):
///         self._end_description()
///
///     def _end_dc_language(self):
///         self._end_language()
///
///     def _end_dc_publisher(self):
///         self._end_webmaster()
///
///     def _end_dc_rights(self):
///         self._end_rights()
///
///     def _end_dc_subject(self):
///         self._end_category()
///
///     def _end_dc_title(self):
///         self._end_title()
///
///     def _end_dcterms_created(self):
///         self._end_created()
///
///     def _end_dcterms_issued(self):
///         self._end_published()
///
///     def _end_dcterms_modified(self):
///         self._end_updated()
///
///     def _start_dc_author(self, attrs_d):
///         self._start_author(attrs_d)
///
///     def _start_dc_creator(self, attrs_d):
///         self._start_author(attrs_d)
///
///     def _start_dc_date(self, attrs_d):
///         self._start_updated(attrs_d)
///
///     def _start_dc_description(self, attrs_d):
///         self._start_description(attrs_d)
///
///     def _start_dc_language(self, attrs_d):
///         self._start_language(attrs_d)
///
///     def _start_dc_publisher(self, attrs_d):
///         self._start_webmaster(attrs_d)
///
///     def _start_dc_rights(self, attrs_d):
///         self._start_rights(attrs_d)
///
///     def _start_dc_subject(self, attrs_d):
///         self._start_category(attrs_d)
///
///     def _start_dc_title(self, attrs_d):
///         self._start_title(attrs_d)
///
///     def _start_dcterms_created(self, attrs_d):
///         self._start_created(attrs_d)
///
///     def _start_dcterms_issued(self, attrs_d):
///         self._start_published(attrs_d)
///
///     def _start_dcterms_modified(self, attrs_d):
///         self._start_updated(attrs_d)
///
///     def _start_dcterms_valid(self, attrs_d):
///         self.push('validity', 1)
///
///     def _end_dcterms_valid(self):
///         for validity_detail in self.pop('validity').split(';'):
///             if '=' in validity_detail:
///                 key, value = validity_detail.split('=', 1)
///                 if key == 'start':
///                     self._save('validity_start', value, overwrite=True)
///                     self._save('validity_start_parsed', _parse_date(value), overwrite=True)
///                 elif key == 'end':
///                     self._save('validity_end', value, overwrite=True)
///                     self._save('validity_end_parsed', _parse_date(value), overwrite=True)
///
///     def _start_dc_contributor(self, attrs_d):
///         self.incontributor = 1
///         context = self._get_context()
///         context.setdefault('contributors', [])
///         context['contributors'].append(FeedParserDict())
///         self.push('name', 0)
///
///     def _end_dc_contributor(self):
///         self._end_name()
///         self.incontributor = 0
/// ```
final class dc extends PythonModule {
  dc.from(super.pythonModule) : super.from();

  static dc import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.dc",
        dc.from,
      );
}

/// ## georss
///
/// ### python source
/// ```py
/// # Support for the GeoRSS format
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
/// # Required for Python 3.6 compatibility.
/// from __future__ import generator_stop
///
/// from ..util import FeedParserDict
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         'http://www.w3.org/2003/01/geo/wgs84_pos#': 'geo',
///         'http://www.georss.org/georss': 'georss',
///         'http://www.opengis.net/gml': 'gml',
///     }
///
///     def __init__(self):
///         self.ingeometry = 0
///         super(Namespace, self).__init__()
///
///     def _start_georssgeom(self, attrs_d):
///         self.push('geometry', 0)
///         context = self._get_context()
///         context['where'] = FeedParserDict()
///
///     _start_georss_point = _start_georssgeom
///     _start_georss_line = _start_georssgeom
///     _start_georss_polygon = _start_georssgeom
///     _start_georss_box = _start_georssgeom
///
///     def _save_where(self, geometry):
///         context = self._get_context()
///         context['where'].update(geometry)
///
///     def _end_georss_point(self):
///         geometry = _parse_georss_point(self.pop('geometry'))
///         if geometry:
///             self._save_where(geometry)
///
///     def _end_georss_line(self):
///         geometry = _parse_georss_line(self.pop('geometry'))
///         if geometry:
///             self._save_where(geometry)
///
///     def _end_georss_polygon(self):
///         this = self.pop('geometry')
///         geometry = _parse_georss_polygon(this)
///         if geometry:
///             self._save_where(geometry)
///
///     def _end_georss_box(self):
///         geometry = _parse_georss_box(self.pop('geometry'))
///         if geometry:
///             self._save_where(geometry)
///
///     def _start_where(self, attrs_d):
///         self.push('where', 0)
///         context = self._get_context()
///         context['where'] = FeedParserDict()
///     _start_georss_where = _start_where
///
///     def _parse_srs_attrs(self, attrs_d):
///         srs_name = attrs_d.get('srsname')
///         try:
///             srs_dimension = int(attrs_d.get('srsdimension', '2'))
///         except ValueError:
///             srs_dimension = 2
///         context = self._get_context()
///         if 'where' not in context:
///             context['where'] = {}
///         context['where']['srsName'] = srs_name
///         context['where']['srsDimension'] = srs_dimension
///
///     def _start_gml_point(self, attrs_d):
///         self._parse_srs_attrs(attrs_d)
///         self.ingeometry = 1
///         self.push('geometry', 0)
///
///     def _start_gml_linestring(self, attrs_d):
///         self._parse_srs_attrs(attrs_d)
///         self.ingeometry = 'linestring'
///         self.push('geometry', 0)
///
///     def _start_gml_polygon(self, attrs_d):
///         self._parse_srs_attrs(attrs_d)
///         self.push('geometry', 0)
///
///     def _start_gml_exterior(self, attrs_d):
///         self.push('geometry', 0)
///
///     def _start_gml_linearring(self, attrs_d):
///         self.ingeometry = 'polygon'
///         self.push('geometry', 0)
///
///     def _start_gml_pos(self, attrs_d):
///         self.push('pos', 0)
///
///     def _end_gml_pos(self):
///         this = self.pop('pos')
///         context = self._get_context()
///         srs_name = context['where'].get('srsName')
///         srs_dimension = context['where'].get('srsDimension', 2)
///         swap = True
///         if srs_name and "EPSG" in srs_name:
///             epsg = int(srs_name.split(":")[-1])
///             swap = bool(epsg in _geogCS)
///         geometry = _parse_georss_point(this, swap=swap, dims=srs_dimension)
///         if geometry:
///             self._save_where(geometry)
///
///     def _start_gml_poslist(self, attrs_d):
///         self.push('pos', 0)
///
///     def _end_gml_poslist(self):
///         this = self.pop('pos')
///         context = self._get_context()
///         srs_name = context['where'].get('srsName')
///         srs_dimension = context['where'].get('srsDimension', 2)
///         swap = True
///         if srs_name and "EPSG" in srs_name:
///             epsg = int(srs_name.split(":")[-1])
///             swap = bool(epsg in _geogCS)
///         geometry = _parse_poslist(
///             this, self.ingeometry, swap=swap, dims=srs_dimension)
///         if geometry:
///             self._save_where(geometry)
///
///     def _end_geom(self):
///         self.ingeometry = 0
///         self.pop('geometry')
///     _end_gml_point = _end_geom
///     _end_gml_linestring = _end_geom
///     _end_gml_linearring = _end_geom
///     _end_gml_exterior = _end_geom
///     _end_gml_polygon = _end_geom
///
///     def _end_where(self):
///         self.pop('where')
///     _end_georss_where = _end_where
///
///
/// # GeoRSS geometry parsers. Each return a dict with 'type' and 'coordinates'
/// # items, or None in the case of a parsing error.
///
/// def _parse_poslist(value, geom_type, swap=True, dims=2):
///     if geom_type == 'linestring':
///         return _parse_georss_line(value, swap, dims)
///     elif geom_type == 'polygon':
///         ring = _parse_georss_line(value, swap, dims)
///         return {'type': 'Polygon', 'coordinates': (ring['coordinates'],)}
///     else:
///         return None
///
///
/// def _gen_georss_coords(value, swap=True, dims=2):
///     # A generator of (lon, lat) pairs from a string of encoded GeoRSS
///     # coordinates. Converts to floats and swaps order.
///     latlons = (float(ll) for ll in value.replace(',', ' ').split())
///     while True:
///         try:
///             t = [next(latlons), next(latlons)][::swap and -1 or 1]
///             if dims == 3:
///                 t.append(next(latlons))
///             yield tuple(t)
///         except StopIteration:
///             return
///
///
/// def _parse_georss_point(value, swap=True, dims=2):
///     # A point contains a single latitude-longitude pair, separated by
///     # whitespace. We'll also handle comma separators.
///     try:
///         coords = list(_gen_georss_coords(value, swap, dims))
///         return {'type': 'Point', 'coordinates': coords[0]}
///     except (IndexError, ValueError):
///         return None
///
///
/// def _parse_georss_line(value, swap=True, dims=2):
///     # A line contains a space separated list of latitude-longitude pairs in
///     # WGS84 coordinate reference system, with each pair separated by
///     # whitespace. There must be at least two pairs.
///     try:
///         coords = list(_gen_georss_coords(value, swap, dims))
///         return {'type': 'LineString', 'coordinates': coords}
///     except (IndexError, ValueError):
///         return None
///
///
/// def _parse_georss_polygon(value, swap=True, dims=2):
///     # A polygon contains a space separated list of latitude-longitude pairs,
///     # with each pair separated by whitespace. There must be at least four
///     # pairs, with the last being identical to the first (so a polygon has a
///     # minimum of three actual points).
///     try:
///         ring = list(_gen_georss_coords(value, swap, dims))
///     except (IndexError, ValueError):
///         return None
///     if len(ring) < 4:
///         return None
///     return {'type': 'Polygon', 'coordinates': (ring,)}
///
///
/// def _parse_georss_box(value, swap=True, dims=2):
///     # A bounding box is a rectangular region, often used to define the extents
///     # of a map or a rough area of interest. A box contains two space separate
///     # latitude-longitude pairs, with each pair separated by whitespace. The
///     # first pair is the lower corner, the second is the upper corner.
///     try:
///         coords = list(_gen_georss_coords(value, swap, dims))
///         return {'type': 'Box', 'coordinates': tuple(coords)}
///     except (IndexError, ValueError):
///         return None
///
///
/// # The list of EPSG codes for geographic (latitude/longitude) coordinate
/// # systems to support decoding of GeoRSS GML profiles.
/// _geogCS = [
///     3819, 3821, 3824, 3889, 3906, 4001, 4002, 4003, 4004, 4005, 4006, 4007, 4008,
///     4009, 4010, 4011, 4012, 4013, 4014, 4015, 4016, 4018, 4019, 4020, 4021, 4022,
///     4023, 4024, 4025, 4027, 4028, 4029, 4030, 4031, 4032, 4033, 4034, 4035, 4036,
///     4041, 4042, 4043, 4044, 4045, 4046, 4047, 4052, 4053, 4054, 4055, 4075, 4081,
///     4120, 4121, 4122, 4123, 4124, 4125, 4126, 4127, 4128, 4129, 4130, 4131, 4132,
///     4133, 4134, 4135, 4136, 4137, 4138, 4139, 4140, 4141, 4142, 4143, 4144, 4145,
///     4146, 4147, 4148, 4149, 4150, 4151, 4152, 4153, 4154, 4155, 4156, 4157, 4158,
///     4159, 4160, 4161, 4162, 4163, 4164, 4165, 4166, 4167, 4168, 4169, 4170, 4171,
///     4172, 4173, 4174, 4175, 4176, 4178, 4179, 4180, 4181, 4182, 4183, 4184, 4185,
///     4188, 4189, 4190, 4191, 4192, 4193, 4194, 4195, 4196, 4197, 4198, 4199, 4200,
///     4201, 4202, 4203, 4204, 4205, 4206, 4207, 4208, 4209, 4210, 4211, 4212, 4213,
///     4214, 4215, 4216, 4218, 4219, 4220, 4221, 4222, 4223, 4224, 4225, 4226, 4227,
///     4228, 4229, 4230, 4231, 4232, 4233, 4234, 4235, 4236, 4237, 4238, 4239, 4240,
///     4241, 4242, 4243, 4244, 4245, 4246, 4247, 4248, 4249, 4250, 4251, 4252, 4253,
///     4254, 4255, 4256, 4257, 4258, 4259, 4260, 4261, 4262, 4263, 4264, 4265, 4266,
///     4267, 4268, 4269, 4270, 4271, 4272, 4273, 4274, 4275, 4276, 4277, 4278, 4279,
///     4280, 4281, 4282, 4283, 4284, 4285, 4286, 4287, 4288, 4289, 4291, 4292, 4293,
///     4294, 4295, 4296, 4297, 4298, 4299, 4300, 4301, 4302, 4303, 4304, 4306, 4307,
///     4308, 4309, 4310, 4311, 4312, 4313, 4314, 4315, 4316, 4317, 4318, 4319, 4322,
///     4324, 4326, 4463, 4470, 4475, 4483, 4490, 4555, 4558, 4600, 4601, 4602, 4603,
///     4604, 4605, 4606, 4607, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616,
///     4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4626, 4627, 4628, 4629,
///     4630, 4631, 4632, 4633, 4634, 4635, 4636, 4637, 4638, 4639, 4640, 4641, 4642,
///     4643, 4644, 4645, 4646, 4657, 4658, 4659, 4660, 4661, 4662, 4663, 4664, 4665,
///     4666, 4667, 4668, 4669, 4670, 4671, 4672, 4673, 4674, 4675, 4676, 4677, 4678,
///     4679, 4680, 4681, 4682, 4683, 4684, 4685, 4686, 4687, 4688, 4689, 4690, 4691,
///     4692, 4693, 4694, 4695, 4696, 4697, 4698, 4699, 4700, 4701, 4702, 4703, 4704,
///     4705, 4706, 4707, 4708, 4709, 4710, 4711, 4712, 4713, 4714, 4715, 4716, 4717,
///     4718, 4719, 4720, 4721, 4722, 4723, 4724, 4725, 4726, 4727, 4728, 4729, 4730,
///     4731, 4732, 4733, 4734, 4735, 4736, 4737, 4738, 4739, 4740, 4741, 4742, 4743,
///     4744, 4745, 4746, 4747, 4748, 4749, 4750, 4751, 4752, 4753, 4754, 4755, 4756,
///     4757, 4758, 4759, 4760, 4761, 4762, 4763, 4764, 4765, 4801, 4802, 4803, 4804,
///     4805, 4806, 4807, 4808, 4809, 4810, 4811, 4813, 4814, 4815, 4816, 4817, 4818,
///     4819, 4820, 4821, 4823, 4824, 4901, 4902, 4903, 4904, 4979,
/// ]
/// ```
final class georss extends PythonModule {
  georss.from(super.pythonModule) : super.from();

  static georss import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.georss",
        georss.from,
      );
}

/// ## itunes
///
/// ### python source
/// ```py
/// # Support for the iTunes format
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
/// from ..util import FeedParserDict
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         # Canonical namespace
///         'http://www.itunes.com/DTDs/PodCast-1.0.dtd': 'itunes',
///
///         # Extra namespace
///         'http://example.com/DTDs/PodCast-1.0.dtd': 'itunes',
///     }
///
///     def _start_itunes_author(self, attrs_d):
///         self._start_author(attrs_d)
///
///     def _end_itunes_author(self):
///         self._end_author()
///
///     def _end_itunes_category(self):
///         self._end_category()
///
///     def _start_itunes_name(self, attrs_d):
///         self._start_name(attrs_d)
///
///     def _end_itunes_name(self):
///         self._end_name()
///
///     def _start_itunes_email(self, attrs_d):
///         self._start_email(attrs_d)
///
///     def _end_itunes_email(self):
///         self._end_email()
///
///     def _start_itunes_subtitle(self, attrs_d):
///         self._start_subtitle(attrs_d)
///
///     def _end_itunes_subtitle(self):
///         self._end_subtitle()
///
///     def _start_itunes_summary(self, attrs_d):
///         self._start_summary(attrs_d)
///
///     def _end_itunes_summary(self):
///         self._end_summary()
///
///     def _start_itunes_owner(self, attrs_d):
///         self.inpublisher = 1
///         self.push('publisher', 0)
///
///     def _end_itunes_owner(self):
///         self.pop('publisher')
///         self.inpublisher = 0
///         self._sync_author_detail('publisher')
///
///     def _end_itunes_keywords(self):
///         for term in self.pop('itunes_keywords').split(','):
///             if term.strip():
///                 self._add_tag(term.strip(), 'http://www.itunes.com/', None)
///
///     def _start_itunes_category(self, attrs_d):
///         self._add_tag(attrs_d.get('text'), 'http://www.itunes.com/', None)
///         self.push('category', 1)
///
///     def _start_itunes_image(self, attrs_d):
///         self.push('itunes_image', 0)
///         if attrs_d.get('href'):
///             self._get_context()['image'] = FeedParserDict({'href': attrs_d.get('href')})
///         elif attrs_d.get('url'):
///             self._get_context()['image'] = FeedParserDict({'href': attrs_d.get('url')})
///     _start_itunes_link = _start_itunes_image
///
///     def _end_itunes_block(self):
///         value = self.pop('itunes_block', 0)
///         self._get_context()['itunes_block'] = (value == 'yes' or value == 'Yes') and 1 or 0
///
///     def _end_itunes_explicit(self):
///         value = self.pop('itunes_explicit', 0)
///         # Convert 'yes' -> True, 'clean' to False, and any other value to None
///         # False and None both evaluate as False, so the difference can be ignored
///         # by applications that only need to know if the content is explicit.
///         self._get_context()['itunes_explicit'] = (None, False, True)[(value == 'yes' and 2) or value == 'clean' or 0]
/// ```
final class itunes extends PythonModule {
  itunes.from(super.pythonModule) : super.from();

  static itunes import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.itunes",
        itunes.from,
      );
}

/// ## mediarss
///
/// ### python source
/// ```py
/// # Support for the Media RSS format
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
/// from ..util import FeedParserDict
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         # Canonical namespace
///         'http://search.yahoo.com/mrss/': 'media',
///
///         # Old namespace (no trailing slash)
///         'http://search.yahoo.com/mrss': 'media',
///     }
///
///     def _start_media_category(self, attrs_d):
///         attrs_d.setdefault('scheme', 'http://search.yahoo.com/mrss/category_schema')
///         self._start_category(attrs_d)
///
///     def _end_media_category(self):
///         self._end_category()
///
///     def _end_media_keywords(self):
///         for term in self.pop('media_keywords').split(','):
///             if term.strip():
///                 self._add_tag(term.strip(), None, None)
///
///     def _start_media_title(self, attrs_d):
///         self._start_title(attrs_d)
///
///     def _end_media_title(self):
///         title_depth = self.title_depth
///         self._end_title()
///         self.title_depth = title_depth
///
///     def _start_media_group(self, attrs_d):
///         # don't do anything, but don't break the enclosed tags either
///         pass
///
///     def _start_media_rating(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_rating', attrs_d)
///         self.push('rating', 1)
///
///     def _end_media_rating(self):
///         rating = self.pop('rating')
///         if rating is not None and rating.strip():
///             context = self._get_context()
///             context['media_rating']['content'] = rating
///
///     def _start_media_credit(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_credit', [])
///         context['media_credit'].append(attrs_d)
///         self.push('credit', 1)
///
///     def _end_media_credit(self):
///         credit = self.pop('credit')
///         if credit is not None and credit.strip():
///             context = self._get_context()
///             context['media_credit'][-1]['content'] = credit
///
///     def _start_media_description(self, attrs_d):
///         self._start_description(attrs_d)
///
///     def _end_media_description(self):
///         self._end_description()
///
///     def _start_media_restriction(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_restriction', attrs_d)
///         self.push('restriction', 1)
///
///     def _end_media_restriction(self):
///         restriction = self.pop('restriction')
///         if restriction is not None and restriction.strip():
///             context = self._get_context()
///             context['media_restriction']['content'] = [cc.strip().lower() for cc in restriction.split(' ')]
///
///     def _start_media_license(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_license', attrs_d)
///         self.push('license', 1)
///
///     def _end_media_license(self):
///         license_ = self.pop('license')
///         if license_ is not None and license_.strip():
///             context = self._get_context()
///             context['media_license']['content'] = license_
///
///     def _start_media_content(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_content', [])
///         context['media_content'].append(attrs_d)
///
///     def _start_media_thumbnail(self, attrs_d):
///         context = self._get_context()
///         context.setdefault('media_thumbnail', [])
///         self.push('url', 1) # new
///         context['media_thumbnail'].append(attrs_d)
///
///     def _end_media_thumbnail(self):
///         url = self.pop('url')
///         context = self._get_context()
///         if url is not None and url.strip():
///             if 'url' not in context['media_thumbnail'][-1]:
///                 context['media_thumbnail'][-1]['url'] = url
///
///     def _start_media_player(self, attrs_d):
///         self.push('media_player', 0)
///         self._get_context()['media_player'] = FeedParserDict(attrs_d)
///
///     def _end_media_player(self):
///         value = self.pop('media_player')
///         context = self._get_context()
///         context['media_player']['content'] = value
/// ```
final class mediarss extends PythonModule {
  mediarss.from(super.pythonModule) : super.from();

  static mediarss import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.mediarss",
        mediarss.from,
      );
}

/// ## psc
///
/// ### python source
/// ```py
/// # Support for the Podlove Simple Chapters format
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
/// import datetime
/// import re
///
/// from .. import util
///
///
/// class Namespace(object):
///     supported_namespaces = {
///         'http://podlove.org/simple-chapters': 'psc',
///     }
///
///     def __init__(self):
///         # chapters will only be captured while psc_chapters_flag is True.
///         self.psc_chapters_flag = False
///         super(Namespace, self).__init__()
///
///     def _start_psc_chapters(self, attrs_d):
///         context = self._get_context()
///         if 'psc_chapters' not in context:
///             self.psc_chapters_flag = True
///             attrs_d['chapters'] = []
///             context['psc_chapters'] = util.FeedParserDict(attrs_d)
///
///     def _end_psc_chapters(self):
///         self.psc_chapters_flag = False
///
///     def _start_psc_chapter(self, attrs_d):
///         if self.psc_chapters_flag:
///             start = self._get_attribute(attrs_d, 'start')
///             attrs_d['start_parsed'] = _parse_psc_chapter_start(start)
///
///             context = self._get_context()['psc_chapters']
///             context['chapters'].append(util.FeedParserDict(attrs_d))
///
///
/// format_ = re.compile(r'^((\d{2}):)?(\d{2}):(\d{2})(\.(\d{3}))?$')
///
///
/// def _parse_psc_chapter_start(start):
///     m = format_.match(start)
///     if m is None:
///         return None
///
///     _, h, m, s, _, ms = m.groups()
///     h, m, s, ms = (int(h or 0), int(m), int(s), int(ms or 0))
///     return datetime.timedelta(0, h*60*60 + m*60 + s, ms*1000)
/// ```
final class psc extends PythonModule {
  psc.from(super.pythonModule) : super.from();

  static psc import() => PythonFfiDart.instance.importModule(
        "feedparser.namespaces.psc",
        psc.from,
      );
}

/// ## util
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
/// import warnings
///
///
/// class FeedParserDict(dict):
///     keymap = {
///         'channel': 'feed',
///         'items': 'entries',
///         'guid': 'id',
///         'date': 'updated',
///         'date_parsed': 'updated_parsed',
///         'description': ['summary', 'subtitle'],
///         'description_detail': ['summary_detail', 'subtitle_detail'],
///         'url': ['href'],
///         'modified': 'updated',
///         'modified_parsed': 'updated_parsed',
///         'issued': 'published',
///         'issued_parsed': 'published_parsed',
///         'copyright': 'rights',
///         'copyright_detail': 'rights_detail',
///         'tagline': 'subtitle',
///         'tagline_detail': 'subtitle_detail',
///     }
///
///     def __getitem__(self, key):
///         """
///         :return: A :class:`FeedParserDict`.
///         """
///
///         if key == 'category':
///             try:
///                 return dict.__getitem__(self, 'tags')[0]['term']
///             except IndexError:
///                 raise KeyError("object doesn't have key 'category'")
///         elif key == 'enclosures':
///             norel = lambda link: FeedParserDict([(name, value) for (name, value) in link.items() if name != 'rel'])
///             return [
///                 norel(link)
///                 for link in dict.__getitem__(self, 'links')
///                 if link['rel'] == 'enclosure'
///             ]
///         elif key == 'license':
///             for link in dict.__getitem__(self, 'links'):
///                 if link['rel'] == 'license' and 'href' in link:
///                     return link['href']
///         elif key == 'updated':
///             # Temporarily help developers out by keeping the old
///             # broken behavior that was reported in issue 310.
///             # This fix was proposed in issue 328.
///             if (
///                     not dict.__contains__(self, 'updated')
///                     and dict.__contains__(self, 'published')
///             ):
///                 warnings.warn(
///                     "To avoid breaking existing software while "
///                     "fixing issue 310, a temporary mapping has been created "
///                     "from `updated` to `published` if `updated` doesn't "
///                     "exist. This fallback will be removed in a future version "
///                     "of feedparser.",
///                     DeprecationWarning,
///                 )
///                 return dict.__getitem__(self, 'published')
///             return dict.__getitem__(self, 'updated')
///         elif key == 'updated_parsed':
///             if (
///                     not dict.__contains__(self, 'updated_parsed')
///                     and dict.__contains__(self, 'published_parsed')
///             ):
///                 warnings.warn(
///                     "To avoid breaking existing software while "
///                     "fixing issue 310, a temporary mapping has been created "
///                     "from `updated_parsed` to `published_parsed` if "
///                     "`updated_parsed` doesn't exist. This fallback will be "
///                     "removed in a future version of feedparser.",
///                     DeprecationWarning,
///                 )
///                 return dict.__getitem__(self, 'published_parsed')
///             return dict.__getitem__(self, 'updated_parsed')
///         else:
///             realkey = self.keymap.get(key, key)
///             if isinstance(realkey, list):
///                 for k in realkey:
///                     if dict.__contains__(self, k):
///                         return dict.__getitem__(self, k)
///             elif dict.__contains__(self, realkey):
///                 return dict.__getitem__(self, realkey)
///         return dict.__getitem__(self, key)
///
///     def __contains__(self, key):
///         if key in ('updated', 'updated_parsed'):
///             # Temporarily help developers out by keeping the old
///             # broken behavior that was reported in issue 310.
///             # This fix was proposed in issue 328.
///             return dict.__contains__(self, key)
///         try:
///             self.__getitem__(key)
///         except KeyError:
///             return False
///         else:
///             return True
///
///     has_key = __contains__
///
///     def get(self, key, default=None):
///         """
///         :return: A :class:`FeedParserDict`.
///         """
///
///         try:
///             return self.__getitem__(key)
///         except KeyError:
///             return default
///
///     def __setitem__(self, key, value):
///         key = self.keymap.get(key, key)
///         if isinstance(key, list):
///             key = key[0]
///         return dict.__setitem__(self, key, value)
///
///     def setdefault(self, k, default):
///         if k not in self:
///             self[k] = default
///             return default
///         return self[k]
///
///     def __getattr__(self, key):
///         # __getattribute__() is called first; this will be called
///         # only if an attribute was not already found
///         try:
///             return self.__getitem__(key)
///         except KeyError:
///             raise AttributeError("object has no attribute '%s'" % key)
///
///     def __hash__(self):
///         # This is incorrect behavior -- dictionaries shouldn't be hashable.
///         # Note to self: remove this behavior in the future.
///         return id(self)
/// ```
final class util extends PythonModule {
  util.from(super.pythonModule) : super.from();

  static util import() => PythonFfiDart.instance.importModule(
        "feedparser.util",
        util.from,
      );
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
        "feedparser.sgmllib",
        sgmllib.from,
      );
}
