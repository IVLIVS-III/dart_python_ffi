// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library feedparser;

import "package:python_ffi/python_ffi.dart";

/// ## CharacterEncodingOverride
///
/// ### python source
/// ```py
/// class CharacterEncodingOverride(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class CharacterEncodingOverride extends PythonClass {
  factory CharacterEncodingOverride() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory CharacterEncodingUnknown() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory FeedParserDict() => PythonFfi.instance.importClass(
        "feedparser",
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

/// ## NonXMLContentType
///
/// ### python source
/// ```py
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class NonXMLContentType extends PythonClass {
  factory NonXMLContentType() => PythonFfi.instance.importClass(
        "feedparser",
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

/// ## ThingsNobodyCaresAboutButMe
///
/// ### python source
/// ```py
/// class ThingsNobodyCaresAboutButMe(Exception):
///     pass
/// ```
final class ThingsNobodyCaresAboutButMe extends PythonClass {
  factory ThingsNobodyCaresAboutButMe() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory UndeclaredNamespace() => PythonFfi.instance.importClass(
        "feedparser",
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
      PythonFfi.instance.importClass(
        "feedparser",
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
      PythonFfi.instance.importClass(
        "feedparser",
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

/// ## error
final class error extends PythonClass {
  factory error() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory Error() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory Incomplete() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory Namespace() => PythonFfi.instance.importClass(
        "feedparser",
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
  factory SGMLParseError() => PythonFfi.instance.importClass(
        "feedparser",
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
      PythonFfi.instance.importClass(
        "feedparser",
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
      PythonFfi.instance.importClass(
        "feedparser",
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

/// ## struct_time
///
/// ### python docstring
///
/// The time value as returned by gmtime(), localtime(), and strptime(), and
/// accepted by asctime(), mktime() and strftime().  May be considered as a
/// sequence of 9 integers.
///
/// Note that several fields' values are not the same as those defined by
/// the C language standard for struct tm.  For example, the value of the
/// field tm_year is the actual year, not year - 1900.  See individual
/// fields' descriptions for details.
final class struct_time extends PythonClass {
  factory struct_time() => PythonFfi.instance.importClass(
        "feedparser",
        "struct_time",
        struct_time.from,
        <Object?>[],
      );

  struct_time.from(super.pythonClass) : super.from();

  /// ## tm_gmtoff (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_gmtoff => getAttribute("tm_gmtoff");

  /// ## tm_gmtoff (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_gmtoff(Object? tm_gmtoff) => setAttribute("tm_gmtoff", tm_gmtoff);

  /// ## tm_hour (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_hour => getAttribute("tm_hour");

  /// ## tm_hour (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_hour(Object? tm_hour) => setAttribute("tm_hour", tm_hour);

  /// ## tm_isdst (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_isdst => getAttribute("tm_isdst");

  /// ## tm_isdst (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_isdst(Object? tm_isdst) => setAttribute("tm_isdst", tm_isdst);

  /// ## tm_mday (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_mday => getAttribute("tm_mday");

  /// ## tm_mday (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_mday(Object? tm_mday) => setAttribute("tm_mday", tm_mday);

  /// ## tm_min (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_min => getAttribute("tm_min");

  /// ## tm_min (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_min(Object? tm_min) => setAttribute("tm_min", tm_min);

  /// ## tm_mon (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_mon => getAttribute("tm_mon");

  /// ## tm_mon (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_mon(Object? tm_mon) => setAttribute("tm_mon", tm_mon);

  /// ## tm_sec (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_sec => getAttribute("tm_sec");

  /// ## tm_sec (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_sec(Object? tm_sec) => setAttribute("tm_sec", tm_sec);

  /// ## tm_wday (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_wday => getAttribute("tm_wday");

  /// ## tm_wday (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_wday(Object? tm_wday) => setAttribute("tm_wday", tm_wday);

  /// ## tm_yday (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_yday => getAttribute("tm_yday");

  /// ## tm_yday (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_yday(Object? tm_yday) => setAttribute("tm_yday", tm_yday);

  /// ## tm_year (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_year => getAttribute("tm_year");

  /// ## tm_year (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_year(Object? tm_year) => setAttribute("tm_year", tm_year);

  /// ## tm_zone (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get tm_zone => getAttribute("tm_zone");

  /// ## tm_zone (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set tm_zone(Object? tm_zone) => setAttribute("tm_zone", tm_zone);

  /// ## count (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get count => getAttribute("count");

  /// ## count (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set count(Object? count) => setAttribute("count", count);

  /// ## index (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get index => getAttribute("index");

  /// ## index (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set index(Object? index) => setAttribute("index", index);

  /// ## n_fields (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get n_fields => getAttribute("n_fields");

  /// ## n_fields (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set n_fields(Object? n_fields) => setAttribute("n_fields", n_fields);

  /// ## n_sequence_fields (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get n_sequence_fields => getAttribute("n_sequence_fields");

  /// ## n_sequence_fields (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set n_sequence_fields(Object? n_sequence_fields) =>
      setAttribute("n_sequence_fields", n_sequence_fields);

  /// ## n_unnamed_fields (getter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  Object? get n_unnamed_fields => getAttribute("n_unnamed_fields");

  /// ## n_unnamed_fields (setter)
  ///
  /// ### python docstring
  ///
  /// The time value as returned by gmtime(), localtime(), and strptime(), and
  /// accepted by asctime(), mktime() and strftime().  May be considered as a
  /// sequence of 9 integers.
  ///
  /// Note that several fields' values are not the same as those defined by
  /// the C language standard for struct tm.  For example, the value of the
  /// field tm_year is the actual year, not year - 1900.  See individual
  /// fields' descriptions for details.
  set n_unnamed_fields(Object? n_unnamed_fields) =>
      setAttribute("n_unnamed_fields", n_unnamed_fields);
}

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
      PythonFfi.instance.importClass(
        "feedparser",
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
      PythonFfi.instance.importClass(
        "feedparser",
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

/// ## feedparser
///
/// ### python source
/// ```py
/// # Copyright 2010-2022 Kurt McKee <contactme@kurtmckee.org>
/// # Copyright 2002-2008 Mark Pilgrim
/// # All rights reserved.
/// #
/// # This file is part of feedparser.
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
/// # POSSIBILITY OF SUCH DAMAGE."""
///
/// from .api import parse
/// from .datetimes import registerDateHandler
/// from .exceptions import *
/// from .util import FeedParserDict
///
/// __author__ = 'Kurt McKee <contactme@kurtmckee.org>'
/// __license__ = 'BSD 2-clause'
/// __version__ = '6.0.10'
///
/// # HTTP "User-Agent" header to send to servers when downloading feeds.
/// # If you are embedding feedparser in a larger application, you should
/// # change this to your application name and URL.
/// USER_AGENT = "feedparser/%s +https://github.com/kurtmckee/feedparser/" % __version__
///
/// # If you want feedparser to automatically resolve all relative URIs, set this
/// # to 1.
/// RESOLVE_RELATIVE_URIS = 1
///
/// # If you want feedparser to automatically sanitize all potentially unsafe
/// # HTML content, set this to 1.
/// SANITIZE_HTML = 1
/// ```
final class feedparser extends PythonModule {
  feedparser.from(super.pythonModule) : super.from();

  static feedparser import() => PythonFfi.instance.importModule(
        "feedparser",
        feedparser.from,
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

  /// ## api
  api get $api => api.import();

  /// ## datetimes
  datetimes get $datetimes => datetimes.import();

  /// ## encodings
  encodings get $encodings => encodings.import();

  /// ## exceptions
  exceptions get $exceptions => exceptions.import();

  /// ## html
  html get $html => html.import();

  /// ## http
  http get $http => http.import();

  /// ## $mixin
  $mixin get $$mixin => $mixin.import();

  /// ## namespaces
  namespaces get $namespaces => namespaces.import();

  /// ## parsers
  parsers get $parsers => parsers.import();

  /// ## sanitizer
  sanitizer get $sanitizer => sanitizer.import();

  /// ## sgml
  sgml get $sgml => sgml.import();

  /// ## urls
  urls get $urls => urls.import();

  /// ## util
  util get $util => util.import();

  /// ## RESOLVE_RELATIVE_URIS (getter)
  Object? get RESOLVE_RELATIVE_URIS => getAttribute("RESOLVE_RELATIVE_URIS");

  /// ## RESOLVE_RELATIVE_URIS (setter)
  set RESOLVE_RELATIVE_URIS(Object? RESOLVE_RELATIVE_URIS) =>
      setAttribute("RESOLVE_RELATIVE_URIS", RESOLVE_RELATIVE_URIS);

  /// ## SANITIZE_HTML (getter)
  Object? get SANITIZE_HTML => getAttribute("SANITIZE_HTML");

  /// ## SANITIZE_HTML (setter)
  set SANITIZE_HTML(Object? SANITIZE_HTML) =>
      setAttribute("SANITIZE_HTML", SANITIZE_HTML);

  /// ## USER_AGENT (getter)
  Object? get USER_AGENT => getAttribute("USER_AGENT");

  /// ## USER_AGENT (setter)
  set USER_AGENT(Object? USER_AGENT) => setAttribute("USER_AGENT", USER_AGENT);
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

  static api import() => PythonFfi.instance.importModule(
        "feedparser.api",
        api.from,
      );

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

  static http import() => PythonFfi.instance.importModule(
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

  static zlib import() => PythonFfi.instance.importModule(
        "zlib",
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

  static $mixin import() => PythonFfi.instance.importModule(
        "feedparser.mixin",
        $mixin.from,
      );
}

/// ## binascii
final class binascii extends PythonModule {
  binascii.from(super.pythonModule) : super.from();

  static binascii import() => PythonFfi.instance.importModule(
        "binascii",
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

  static cc import() => PythonFfi.instance.importModule(
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

  static dc import() => PythonFfi.instance.importModule(
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

  static georss import() => PythonFfi.instance.importModule(
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

  static itunes import() => PythonFfi.instance.importModule(
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

  static mediarss import() => PythonFfi.instance.importModule(
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

  static psc import() => PythonFfi.instance.importModule(
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

  static util import() => PythonFfi.instance.importModule(
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

  static sgmllib import() => PythonFfi.instance.importModule(
        "sgmllib",
        sgmllib.from,
      );
}

/// ## datetimes
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
/// from .asctime import _parse_date_asctime
/// from .greek import _parse_date_greek
/// from .hungarian import _parse_date_hungarian
/// from .iso8601 import _parse_date_iso8601
/// from .korean import _parse_date_onblog, _parse_date_nate
/// from .perforce import _parse_date_perforce
/// from .rfc822 import _parse_date_rfc822
/// from .w3dtf import _parse_date_w3dtf
///
/// _date_handlers = []
///
///
/// def registerDateHandler(func):
///     """Register a date handler function (takes string, returns 9-tuple date in GMT)"""
///     _date_handlers.insert(0, func)
///
///
/// def _parse_date(date_string):
///     """Parses a variety of date formats into a 9-tuple in GMT"""
///     if not date_string:
///         return None
///     for handler in _date_handlers:
///         try:
///             date9tuple = handler(date_string)
///         except (KeyError, OverflowError, ValueError, AttributeError):
///             continue
///         if not date9tuple:
///             continue
///         if len(date9tuple) != 9:
///             continue
///         return date9tuple
///     return None
///
///
/// registerDateHandler(_parse_date_onblog)
/// registerDateHandler(_parse_date_nate)
/// registerDateHandler(_parse_date_greek)
/// registerDateHandler(_parse_date_hungarian)
/// registerDateHandler(_parse_date_perforce)
/// registerDateHandler(_parse_date_asctime)
/// registerDateHandler(_parse_date_iso8601)
/// registerDateHandler(_parse_date_rfc822)
/// registerDateHandler(_parse_date_w3dtf)
/// ```
final class datetimes extends PythonModule {
  datetimes.from(super.pythonModule) : super.from();

  static datetimes import() => PythonFfi.instance.importModule(
        "feedparser.datetimes",
        datetimes.from,
      );
}

/// ## asctime
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
/// from .rfc822 import _parse_date_rfc822
///
/// _months = [
///     'jan',
///     'feb',
///     'mar',
///     'apr',
///     'may',
///     'jun',
///     'jul',
///     'aug',
///     'sep',
///     'oct',
///     'nov',
///     'dec',
/// ]
///
///
/// def _parse_date_asctime(dt):
///     """Parse asctime-style dates.
///
///     Converts asctime to RFC822-compatible dates and uses the RFC822 parser
///     to do the actual parsing.
///
///     Supported formats (format is standardized to the first one listed):
///
///     * {weekday name} {month name} dd hh:mm:ss {+-tz} yyyy
///     * {weekday name} {month name} dd hh:mm:ss yyyy
///     """
///
///     parts = dt.split()
///
///     # Insert a GMT timezone, if needed.
///     if len(parts) == 5:
///         parts.insert(4, '+0000')
///
///     # Exit if there are not six parts.
///     if len(parts) != 6:
///         return None
///
///     # Reassemble the parts in an RFC822-compatible order and parse them.
///     return _parse_date_rfc822(' '.join([
///         parts[0], parts[2], parts[1], parts[5], parts[3], parts[4],
///     ]))
/// ```
final class asctime extends PythonModule {
  asctime.from(super.pythonModule) : super.from();

  static asctime import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.asctime",
        asctime.from,
      );
}

/// ## greek
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
/// from .rfc822 import _parse_date_rfc822
///
/// # Unicode strings for Greek date strings
/// _greek_months = {
///    '\u0399\u03b1\u03bd': 'Jan',        # c9e1ed in iso-8859-7
///    '\u03a6\u03b5\u03b2': 'Feb',        # d6e5e2 in iso-8859-7
///    '\u039c\u03ac\u03ce': 'Mar',        # ccdcfe in iso-8859-7
///    '\u039c\u03b1\u03ce': 'Mar',        # cce1fe in iso-8859-7
///    '\u0391\u03c0\u03c1': 'Apr',        # c1f0f1 in iso-8859-7
///    '\u039c\u03ac\u03b9': 'May',        # ccdce9 in iso-8859-7
///    '\u039c\u03b1\u03ca': 'May',        # cce1fa in iso-8859-7
///    '\u039c\u03b1\u03b9': 'May',        # cce1e9 in iso-8859-7
///    '\u0399\u03bf\u03cd\u03bd': 'Jun',  # c9effded in iso-8859-7
///    '\u0399\u03bf\u03bd': 'Jun',        # c9efed in iso-8859-7
///    '\u0399\u03bf\u03cd\u03bb': 'Jul',  # c9effdeb in iso-8859-7
///    '\u0399\u03bf\u03bb': 'Jul',        # c9f9eb in iso-8859-7
///    '\u0391\u03cd\u03b3': 'Aug',        # c1fde3 in iso-8859-7
///    '\u0391\u03c5\u03b3': 'Aug',        # c1f5e3 in iso-8859-7
///    '\u03a3\u03b5\u03c0': 'Sep',        # d3e5f0 in iso-8859-7
///    '\u039f\u03ba\u03c4': 'Oct',        # cfeaf4 in iso-8859-7
///    '\u039d\u03bf\u03ad': 'Nov',        # cdefdd in iso-8859-7
///    '\u039d\u03bf\u03b5': 'Nov',        # cdefe5 in iso-8859-7
///    '\u0394\u03b5\u03ba': 'Dec',        # c4e5ea in iso-8859-7
/// }
///
/// _greek_wdays = {
///    '\u039a\u03c5\u03c1': 'Sun',  # caf5f1 in iso-8859-7
///    '\u0394\u03b5\u03c5': 'Mon',  # c4e5f5 in iso-8859-7
///    '\u03a4\u03c1\u03b9': 'Tue',  # d4f1e9 in iso-8859-7
///    '\u03a4\u03b5\u03c4': 'Wed',  # d4e5f4 in iso-8859-7
///    '\u03a0\u03b5\u03bc': 'Thu',  # d0e5ec in iso-8859-7
///    '\u03a0\u03b1\u03c1': 'Fri',  # d0e1f1 in iso-8859-7
///    '\u03a3\u03b1\u03b2': 'Sat',  # d3e1e2 in iso-8859-7
/// }
///
/// _greek_date_format_re = re.compile(r'([^,]+),\s+(\d{2})\s+([^\s]+)\s+(\d{4})\s+(\d{2}):(\d{2}):(\d{2})\s+([^\s]+)')
///
///
/// def _parse_date_greek(date_string):
///     """Parse a string according to a Greek 8-bit date format."""
///     m = _greek_date_format_re.match(date_string)
///     if not m:
///         return
///     wday = _greek_wdays[m.group(1)]
///     month = _greek_months[m.group(3)]
///     rfc822date = '%(wday)s, %(day)s %(month)s %(year)s %(hour)s:%(minute)s:%(second)s %(zonediff)s' % \
///                  {
///                      'wday': wday,
///                      'day': m.group(2),
///                      'month': month,
///                      'year': m.group(4),
///                      'hour': m.group(5),
///                      'minute': m.group(6),
///                      'second': m.group(7),
///                      'zonediff': m.group(8),
///                  }
///     return _parse_date_rfc822(rfc822date)
/// ```
final class greek extends PythonModule {
  greek.from(super.pythonModule) : super.from();

  static greek import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.greek",
        greek.from,
      );
}

/// ## hungarian
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
/// from .w3dtf import _parse_date_w3dtf
///
/// # Unicode strings for Hungarian date strings
/// _hungarian_months = {
///     'janu\u00e1r':   '01',  # e1 in iso-8859-2
///     'febru\u00e1ri': '02',  # e1 in iso-8859-2
///     'm\u00e1rcius':  '03',  # e1 in iso-8859-2
///     '\u00e1prilis':  '04',  # e1 in iso-8859-2
///     'm\u00e1ujus':   '05',  # e1 in iso-8859-2
///     'j\u00fanius':   '06',  # fa in iso-8859-2
///     'j\u00falius':   '07',  # fa in iso-8859-2
///     'augusztus':     '08',
///     'szeptember':    '09',
///     'okt\u00f3ber':  '10',  # f3 in iso-8859-2
///     'november':      '11',
///     'december':      '12',
/// }
///
/// _hungarian_date_format_re = re.compile(r'(\d{4})-([^-]+)-(\d{,2})T(\d{,2}):(\d{2})([+-](\d{,2}:\d{2}))')
///
///
/// def _parse_date_hungarian(date_string):
///     """Parse a string according to a Hungarian 8-bit date format."""
///     m = _hungarian_date_format_re.match(date_string)
///     if not m or m.group(2) not in _hungarian_months:
///         return None
///     month = _hungarian_months[m.group(2)]
///     day = m.group(3)
///     if len(day) == 1:
///         day = '0' + day
///     hour = m.group(4)
///     if len(hour) == 1:
///         hour = '0' + hour
///     w3dtfdate = '%(year)s-%(month)s-%(day)sT%(hour)s:%(minute)s%(zonediff)s' % \
///                 {
///                     'year': m.group(1),
///                     'month': month,
///                     'day': day,
///                     'hour': hour,
///                     'minute': m.group(5),
///                     'zonediff': m.group(6),
///                 }
///     return _parse_date_w3dtf(w3dtfdate)
/// ```
final class hungarian extends PythonModule {
  hungarian.from(super.pythonModule) : super.from();

  static hungarian import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.hungarian",
        hungarian.from,
      );
}

/// ## iso8601
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
/// import time
///
/// # ISO-8601 date parsing routines written by Fazal Majid.
/// # The ISO 8601 standard is very convoluted and irregular - a full ISO 8601
/// # parser is beyond the scope of feedparser and would be a worthwhile addition
/// # to the Python library.
/// # A single regular expression cannot parse ISO 8601 date formats into groups
/// # as the standard is highly irregular (for instance is 030104 2003-01-04 or
/// # 0301-04-01), so we use templates instead.
/// # Please note the order in templates is significant because we need a
/// # greedy match.
/// _iso8601_tmpl = [
///     'YYYY-?MM-?DD',
///     'YYYY-0MM?-?DD',
///     'YYYY-MM',
///     'YYYY-?OOO',
///     'YY-?MM-?DD',
///     'YY-?OOO',
///     'YYYY',
///     '-YY-?MM',
///     '-OOO',
///     '-YY',
///     '--MM-?DD',
///     '--MM',
///     '---DD',
///     'CC',
///     '',
/// ]
///
/// _iso8601_re = [
///     tmpl.replace(
///     'YYYY', r'(?P<year>\d{4})').replace(
///     'YY', r'(?P<year>\d\d)').replace(
///     'MM', r'(?P<month>[01]\d)').replace(
///     'DD', r'(?P<day>[0123]\d)').replace(
///     'OOO', r'(?P<ordinal>[0123]\d\d)').replace(
///     'CC', r'(?P<century>\d\d$)')
///     + r'(T?(?P<hour>\d{2}):(?P<minute>\d{2})'
///     + r'(:(?P<second>\d{2}))?'
///     + r'(\.(?P<fracsecond>\d+))?'
///     + r'(?P<tz>[+-](?P<tzhour>\d{2})(:(?P<tzmin>\d{2}))?|Z)?)?'
///     for tmpl in _iso8601_tmpl]
/// try:
///     del tmpl
/// except NameError:
///     pass
/// _iso8601_matches = [re.compile(regex).match for regex in _iso8601_re]
/// try:
///     del regex
/// except NameError:
///     pass
///
///
/// def _parse_date_iso8601(date_string):
///     """Parse a variety of ISO-8601-compatible formats like 20040105"""
///     m = None
///     for _iso8601_match in _iso8601_matches:
///         m = _iso8601_match(date_string)
///         if m:
///             break
///     if not m:
///         return
///     if m.span() == (0, 0):
///         return
///     params = m.groupdict()
///     ordinal = params.get('ordinal', 0)
///     if ordinal:
///         ordinal = int(ordinal)
///     else:
///         ordinal = 0
///     year = params.get('year', '--')
///     if not year or year == '--':
///         year = time.gmtime()[0]
///     elif len(year) == 2:
///         # ISO 8601 assumes current century, i.e. 93 -> 2093, NOT 1993
///         year = 100 * int(time.gmtime()[0] / 100) + int(year)
///     else:
///         year = int(year)
///     month = params.get('month', '-')
///     if not month or month == '-':
///         # ordinals are NOT normalized by mktime, we simulate them
///         # by setting month=1, day=ordinal
///         if ordinal:
///             month = 1
///         else:
///             month = time.gmtime()[1]
///     month = int(month)
///     day = params.get('day', 0)
///     if not day:
///         # see above
///         if ordinal:
///             day = ordinal
///         elif params.get('century', 0) or \
///                  params.get('year', 0) or params.get('month', 0):
///             day = 1
///         else:
///             day = time.gmtime()[2]
///     else:
///         day = int(day)
///     # special case of the century - is the first year of the 21st century
///     # 2000 or 2001 ? The debate goes on...
///     if 'century' in params:
///         year = (int(params['century']) - 1) * 100 + 1
///     # in ISO 8601 most fields are optional
///     for field in ['hour', 'minute', 'second', 'tzhour', 'tzmin']:
///         if not params.get(field, None):
///             params[field] = 0
///     hour = int(params.get('hour', 0))
///     minute = int(params.get('minute', 0))
///     second = int(float(params.get('second', 0)))
///     # weekday is normalized by mktime(), we can ignore it
///     weekday = 0
///     daylight_savings_flag = -1
///     tm = [year, month, day, hour, minute, second, weekday,
///           ordinal, daylight_savings_flag]
///     # ISO 8601 time zone adjustments
///     tz = params.get('tz')
///     if tz and tz != 'Z':
///         if tz[0] == '-':
///             tm[3] += int(params.get('tzhour', 0))
///             tm[4] += int(params.get('tzmin', 0))
///         elif tz[0] == '+':
///             tm[3] -= int(params.get('tzhour', 0))
///             tm[4] -= int(params.get('tzmin', 0))
///         else:
///             return None
///     # Python's time.mktime() is a wrapper around the ANSI C mktime(3c)
///     # which is guaranteed to normalize d/m/y/h/m/s.
///     # Many implementations have bugs, but we'll pretend they don't.
///     return time.localtime(time.mktime(tuple(tm)))
/// ```
final class iso8601 extends PythonModule {
  iso8601.from(super.pythonModule) : super.from();

  static iso8601 import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.iso8601",
        iso8601.from,
      );
}

/// ## time
final class time extends PythonModule {
  time.from(super.pythonModule) : super.from();

  static time import() => PythonFfi.instance.importModule(
        "time",
        time.from,
      );

  /// ## CLOCK_MONOTONIC (getter)
  Object? get CLOCK_MONOTONIC => getAttribute("CLOCK_MONOTONIC");

  /// ## CLOCK_MONOTONIC (setter)
  set CLOCK_MONOTONIC(Object? CLOCK_MONOTONIC) =>
      setAttribute("CLOCK_MONOTONIC", CLOCK_MONOTONIC);

  /// ## CLOCK_MONOTONIC_RAW (getter)
  Object? get CLOCK_MONOTONIC_RAW => getAttribute("CLOCK_MONOTONIC_RAW");

  /// ## CLOCK_MONOTONIC_RAW (setter)
  set CLOCK_MONOTONIC_RAW(Object? CLOCK_MONOTONIC_RAW) =>
      setAttribute("CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW);

  /// ## CLOCK_PROCESS_CPUTIME_ID (getter)
  Object? get CLOCK_PROCESS_CPUTIME_ID =>
      getAttribute("CLOCK_PROCESS_CPUTIME_ID");

  /// ## CLOCK_PROCESS_CPUTIME_ID (setter)
  set CLOCK_PROCESS_CPUTIME_ID(Object? CLOCK_PROCESS_CPUTIME_ID) =>
      setAttribute("CLOCK_PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID);

  /// ## CLOCK_REALTIME (getter)
  Object? get CLOCK_REALTIME => getAttribute("CLOCK_REALTIME");

  /// ## CLOCK_REALTIME (setter)
  set CLOCK_REALTIME(Object? CLOCK_REALTIME) =>
      setAttribute("CLOCK_REALTIME", CLOCK_REALTIME);

  /// ## CLOCK_THREAD_CPUTIME_ID (getter)
  Object? get CLOCK_THREAD_CPUTIME_ID =>
      getAttribute("CLOCK_THREAD_CPUTIME_ID");

  /// ## CLOCK_THREAD_CPUTIME_ID (setter)
  set CLOCK_THREAD_CPUTIME_ID(Object? CLOCK_THREAD_CPUTIME_ID) =>
      setAttribute("CLOCK_THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID);

  /// ## CLOCK_UPTIME_RAW (getter)
  Object? get CLOCK_UPTIME_RAW => getAttribute("CLOCK_UPTIME_RAW");

  /// ## CLOCK_UPTIME_RAW (setter)
  set CLOCK_UPTIME_RAW(Object? CLOCK_UPTIME_RAW) =>
      setAttribute("CLOCK_UPTIME_RAW", CLOCK_UPTIME_RAW);

  /// ## altzone (getter)
  Object? get altzone => getAttribute("altzone");

  /// ## altzone (setter)
  set altzone(Object? altzone) => setAttribute("altzone", altzone);

  /// ## daylight (getter)
  Object? get daylight => getAttribute("daylight");

  /// ## daylight (setter)
  set daylight(Object? daylight) => setAttribute("daylight", daylight);

  /// ## timezone (getter)
  Object? get timezone => getAttribute("timezone");

  /// ## timezone (setter)
  set timezone(Object? timezone) => setAttribute("timezone", timezone);

  /// ## tzname (getter)
  Object? get tzname => getAttribute("tzname");

  /// ## tzname (setter)
  set tzname(Object? tzname) => setAttribute("tzname", tzname);
}

/// ## korean
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
/// from .w3dtf import _parse_date_w3dtf
///
/// # 8-bit date handling routines written by ytrewq1.
/// _korean_year = '\ub144' # b3e2 in euc-kr
/// _korean_month = '\uc6d4' # bff9 in euc-kr
/// _korean_day = '\uc77c' # c0cf in euc-kr
/// _korean_am = '\uc624\uc804' # bfc0 c0fc in euc-kr
/// _korean_pm = '\uc624\ud6c4' # bfc0 c8c4 in euc-kr
///
/// _korean_onblog_date_re = re.compile(
///     r'(\d{4})%s\s+(\d{2})%s\s+(\d{2})%s\s+(\d{2}):(\d{2}):(\d{2})'
///     % (_korean_year, _korean_month, _korean_day)
/// )
///
/// _korean_nate_date_re = re.compile(
///     r'(\d{4})-(\d{2})-(\d{2})\s+(%s|%s)\s+(\d{,2}):(\d{,2}):(\d{,2})'
///     % (_korean_am, _korean_pm))
///
///
/// def _parse_date_onblog(dateString):
///     """Parse a string according to the OnBlog 8-bit date format"""
///     m = _korean_onblog_date_re.match(dateString)
///     if not m:
///         return
///     w3dtfdate = '%(year)s-%(month)s-%(day)sT%(hour)s:%(minute)s:%(second)s%(zonediff)s' % \
///                 {'year': m.group(1), 'month': m.group(2), 'day': m.group(3),
///                  'hour': m.group(4), 'minute': m.group(5), 'second': m.group(6),
///                  'zonediff': '+09:00'}
///     return _parse_date_w3dtf(w3dtfdate)
///
///
/// def _parse_date_nate(dateString):
///     """Parse a string according to the Nate 8-bit date format"""
///     m = _korean_nate_date_re.match(dateString)
///     if not m:
///         return
///     hour = int(m.group(5))
///     ampm = m.group(4)
///     if ampm == _korean_pm:
///         hour += 12
///     hour = str(hour)
///     if len(hour) == 1:
///         hour = '0' + hour
///     w3dtfdate = '%(year)s-%(month)s-%(day)sT%(hour)s:%(minute)s:%(second)s%(zonediff)s' % \
///                 {
///                     'year': m.group(1),
///                     'month': m.group(2),
///                     'day': m.group(3),
///                     'hour': hour,
///                     'minute': m.group(6),
///                     'second': m.group(7),
///                     'zonediff': '+09:00',
///                 }
///     return _parse_date_w3dtf(w3dtfdate)
/// ```
final class korean extends PythonModule {
  korean.from(super.pythonModule) : super.from();

  static korean import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.korean",
        korean.from,
      );
}

/// ## perforce
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
/// import email._parseaddr
/// import re
/// import time
///
///
/// def _parse_date_perforce(date_string):
///     """parse a date in yyyy/mm/dd hh:mm:ss TTT format"""
///     # Fri, 2006/09/15 08:19:53 EDT
///     _my_date_pattern = re.compile(r'(\w{,3}), (\d{,4})/(\d{,2})/(\d{2}) (\d{,2}):(\d{2}):(\d{2}) (\w{,3})')
///
///     m = _my_date_pattern.search(date_string)
///     if m is None:
///         return None
///     dow, year, month, day, hour, minute, second, tz = m.groups()
///     months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
///     new_date_string = "%s, %s %s %s %s:%s:%s %s" % (dow, day, months[int(month) - 1], year, hour, minute, second, tz)
///     tm = email._parseaddr.parsedate_tz(new_date_string)
///     if tm:
///         return time.gmtime(email._parseaddr.mktime_tz(tm))
/// ```
final class perforce extends PythonModule {
  perforce.from(super.pythonModule) : super.from();

  static perforce import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.perforce",
        perforce.from,
      );
}

/// ## rfc822
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
/// import datetime
///
/// timezone_names = {
///     'ut': 0, 'gmt': 0, 'z': 0,
///     'adt': -3, 'ast': -4, 'at': -4,
///     'edt': -4, 'est': -5, 'et': -5,
///     'cdt': -5, 'cst': -6, 'ct': -6,
///     'mdt': -6, 'mst': -7, 'mt': -7,
///     'pdt': -7, 'pst': -8, 'pt': -8,
///     'a': -1, 'n': 1,
///     'm': -12, 'y': 12,
///     'met': 1, 'mest': 2,
/// }
/// day_names = {'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'}
/// months = {
///     'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
///     'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
/// }
///
///
/// def _parse_date_rfc822(date):
///     """Parse RFC 822 dates and times
///     http://tools.ietf.org/html/rfc822#section-5
///
///     There are some formatting differences that are accounted for:
///     1. Years may be two or four digits.
///     2. The month and day can be swapped.
///     3. Additional timezone names are supported.
///     4. A default time and timezone are assumed if only a date is present.
///
///     :param str date: a date/time string that will be converted to a time tuple
///     :returns: a UTC time tuple, or None
///     :rtype: time.struct_time | None
///     """
///
///     parts = date.lower().split()
///     if len(parts) < 5:
///         # Assume that the time and timezone are missing
///         parts.extend(('00:00:00', '0000'))
///     # Remove the day name
///     if parts[0][:3] in day_names:
///         parts = parts[1:]
///     if len(parts) < 5:
///         # If there are still fewer than five parts, there's not enough
///         # information to interpret this.
///         return None
///
///     # Handle the day and month name.
///     month = months.get(parts[1][:3])
///     try:
///         day = int(parts[0])
///     except ValueError:
///         # Check if the day and month are swapped.
///         if months.get(parts[0][:3]):
///             try:
///                 day = int(parts[1])
///             except ValueError:
///                 return None
///             month = months.get(parts[0][:3])
///         else:
///             return None
///     if not month:
///         return None
///
///     # Handle the year.
///     try:
///         year = int(parts[2])
///     except ValueError:
///         return None
///     # Normalize two-digit years:
///     # Anything in the 90's is interpreted as 1990 and on.
///     # Anything 89 or less is interpreted as 2089 or before.
///     if len(parts[2]) <= 2:
///         year += (1900, 2000)[year < 90]
///
///     # Handle the time (default to 00:00:00).
///     time_parts = parts[3].split(':')
///     time_parts.extend(('0',) * (3 - len(time_parts)))
///     try:
///         (hour, minute, second) = [int(i) for i in time_parts]
///     except ValueError:
///         return None
///
///     # Handle the timezone information, if any (default to +0000).
///     # Strip 'Etc/' from the timezone.
///     if parts[4].startswith('etc/'):
///         parts[4] = parts[4][4:]
///     # Normalize timezones that start with 'gmt':
///     # GMT-05:00 => -0500
///     # GMT => GMT
///     if parts[4].startswith('gmt'):
///         parts[4] = ''.join(parts[4][3:].split(':')) or 'gmt'
///     # Handle timezones like '-0500', '+0500', and 'EST'
///     if parts[4] and parts[4][0] in ('-', '+'):
///         try:
///             if ':' in parts[4]:
///                 timezone_hours = int(parts[4][1:3])
///                 timezone_minutes = int(parts[4][4:])
///             else:
///                 timezone_hours = int(parts[4][1:3])
///                 timezone_minutes = int(parts[4][3:])
///         except ValueError:
///             return None
///         if parts[4].startswith('-'):
///             timezone_hours *= -1
///             timezone_minutes *= -1
///     else:
///         timezone_hours = timezone_names.get(parts[4], 0)
///         timezone_minutes = 0
///
///     # Create the datetime object and timezone delta objects
///     try:
///         stamp = datetime.datetime(year, month, day, hour, minute, second)
///     except ValueError:
///         return None
///     delta = datetime.timedelta(0, 0, 0, 0, timezone_minutes, timezone_hours)
///
///     # Return the date and timestamp in a UTC 9-tuple
///     try:
///         return (stamp - delta).utctimetuple()
///     except (OverflowError, ValueError):
///         # IronPython throws ValueErrors instead of OverflowErrors
///         return None
/// ```
final class rfc822 extends PythonModule {
  rfc822.from(super.pythonModule) : super.from();

  static rfc822 import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.rfc822",
        rfc822.from,
      );

  /// ## day_names (getter)
  Object? get day_names => getAttribute("day_names");

  /// ## day_names (setter)
  set day_names(Object? day_names) => setAttribute("day_names", day_names);

  /// ## months (getter)
  Object? get months => getAttribute("months");

  /// ## months (setter)
  set months(Object? months) => setAttribute("months", months);

  /// ## timezone_names (getter)
  Object? get timezone_names => getAttribute("timezone_names");

  /// ## timezone_names (setter)
  set timezone_names(Object? timezone_names) =>
      setAttribute("timezone_names", timezone_names);
}

/// ## w3dtf
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
/// import datetime
///
/// timezonenames = {
///     'ut': 0, 'gmt': 0, 'z': 0,
///     'adt': -3, 'ast': -4, 'at': -4,
///     'edt': -4, 'est': -5, 'et': -5,
///     'cdt': -5, 'cst': -6, 'ct': -6,
///     'mdt': -6, 'mst': -7, 'mt': -7,
///     'pdt': -7, 'pst': -8, 'pt': -8,
///     'a': -1, 'n': 1,
///     'm': -12, 'y': 12,
/// }
/// # W3 date and time format parser
/// # http://www.w3.org/TR/NOTE-datetime
/// # Also supports MSSQL-style datetimes as defined at:
/// # http://msdn.microsoft.com/en-us/library/ms186724.aspx
/// # (basically, allow a space as a date/time/timezone separator)
///
///
/// def _parse_date_w3dtf(datestr):
///     if not datestr.strip():
///         return None
///     parts = datestr.lower().split('t')
///     if len(parts) == 1:
///         # This may be a date only, or may be an MSSQL-style date
///         parts = parts[0].split()
///         if len(parts) == 1:
///             # Treat this as a date only
///             parts.append('00:00:00z')
///     elif len(parts) > 2:
///         return None
///     date = parts[0].split('-', 2)
///     if not date or len(date[0]) != 4:
///         return None
///     # Ensure that `date` has 3 elements. Using '1' sets the default
///     # month to January and the default day to the 1st of the month.
///     date.extend(['1'] * (3 - len(date)))
///     try:
///         year, month, day = [int(i) for i in date]
///     except ValueError:
///         # `date` may have more than 3 elements or may contain
///         # non-integer strings.
///         return None
///     if parts[1].endswith('z'):
///         parts[1] = parts[1][:-1]
///         parts.append('z')
///     # Append the numeric timezone offset, if any, to parts.
///     # If this is an MSSQL-style date then parts[2] already contains
///     # the timezone information, so `append()` will not affect it.
///     # Add 1 to each value so that if `find()` returns -1 it will be
///     # treated as False.
///     loc = parts[1].find('-') + 1 or parts[1].find('+') + 1 or len(parts[1]) + 1
///     loc = loc - 1
///     parts.append(parts[1][loc:])
///     parts[1] = parts[1][:loc]
///     time = parts[1].split(':', 2)
///     # Ensure that time has 3 elements. Using '0' means that the
///     # minutes and seconds, if missing, will default to 0.
///     time.extend(['0'] * (3 - len(time)))
///     if parts[2][:1] in ('-', '+'):
///         try:
///             tzhour = int(parts[2][1:3])
///             tzmin = int(parts[2][4:])
///         except ValueError:
///             return None
///         if parts[2].startswith('-'):
///             tzhour = tzhour * -1
///             tzmin = tzmin * -1
///     else:
///         tzhour = timezonenames.get(parts[2], 0)
///         tzmin = 0
///     try:
///         hour, minute, second = [int(float(i)) for i in time]
///     except ValueError:
///         return None
///     # Create the datetime object and timezone delta objects
///     try:
///         stamp = datetime.datetime(year, month, day, hour, minute, second)
///     except ValueError:
///         return None
///     delta = datetime.timedelta(0, 0, 0, 0, tzmin, tzhour)
///     # Return the date and timestamp in a UTC 9-tuple
///     try:
///         return (stamp - delta).utctimetuple()
///     except (OverflowError, ValueError):
///         # IronPython throws ValueErrors instead of OverflowErrors
///         return None
/// ```
final class w3dtf extends PythonModule {
  w3dtf.from(super.pythonModule) : super.from();

  static w3dtf import() => PythonFfi.instance.importModule(
        "feedparser.datetimes.w3dtf",
        w3dtf.from,
      );

  /// ## timezonenames (getter)
  Object? get timezonenames => getAttribute("timezonenames");

  /// ## timezonenames (setter)
  set timezonenames(Object? timezonenames) =>
      setAttribute("timezonenames", timezonenames);
}

/// ## encodings
///
/// ### python source
/// ```py
/// # Character encoding routines
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
/// import cgi
/// import codecs
/// import re
///
/// try:
///     try:
///         import cchardet as chardet
///     except ImportError:
///         import chardet
/// except ImportError:
///     chardet = None
///     lazy_chardet_encoding = None
/// else:
///     def lazy_chardet_encoding(data):
///         return chardet.detect(data)['encoding'] or ''
///
/// from .exceptions import (
///     CharacterEncodingOverride,
///     CharacterEncodingUnknown,
///     NonXMLContentType,
/// )
///
///
/// # Each marker represents some of the characters of the opening XML
/// # processing instruction ('<?xm') in the specified encoding.
/// EBCDIC_MARKER = b'\x4C\x6F\xA7\x94'
/// UTF16BE_MARKER = b'\x00\x3C\x00\x3F'
/// UTF16LE_MARKER = b'\x3C\x00\x3F\x00'
/// UTF32BE_MARKER = b'\x00\x00\x00\x3C'
/// UTF32LE_MARKER = b'\x3C\x00\x00\x00'
///
/// ZERO_BYTES = '\x00\x00'
///
/// # Match the opening XML declaration.
/// # Example: <?xml version="1.0" encoding="utf-8"?>
/// RE_XML_DECLARATION = re.compile(r'^<\?xml[^>]*?>')
///
/// # Capture the value of the XML processing instruction's encoding attribute.
/// # Example: <?xml version="1.0" encoding="utf-8"?>
/// RE_XML_PI_ENCODING = re.compile(br'^<\?.*encoding=[\'"](.*?)[\'"].*\?>')
///
///
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
final class encodings extends PythonModule {
  encodings.from(super.pythonModule) : super.from();

  static encodings import() => PythonFfi.instance.importModule(
        "feedparser.encodings",
        encodings.from,
      );

  /// ## EBCDIC_MARKER (getter)
  Object? get EBCDIC_MARKER => getAttribute("EBCDIC_MARKER");

  /// ## EBCDIC_MARKER (setter)
  set EBCDIC_MARKER(Object? EBCDIC_MARKER) =>
      setAttribute("EBCDIC_MARKER", EBCDIC_MARKER);

  /// ## UTF16BE_MARKER (getter)
  Object? get UTF16BE_MARKER => getAttribute("UTF16BE_MARKER");

  /// ## UTF16BE_MARKER (setter)
  set UTF16BE_MARKER(Object? UTF16BE_MARKER) =>
      setAttribute("UTF16BE_MARKER", UTF16BE_MARKER);

  /// ## UTF16LE_MARKER (getter)
  Object? get UTF16LE_MARKER => getAttribute("UTF16LE_MARKER");

  /// ## UTF16LE_MARKER (setter)
  set UTF16LE_MARKER(Object? UTF16LE_MARKER) =>
      setAttribute("UTF16LE_MARKER", UTF16LE_MARKER);

  /// ## UTF32BE_MARKER (getter)
  Object? get UTF32BE_MARKER => getAttribute("UTF32BE_MARKER");

  /// ## UTF32BE_MARKER (setter)
  set UTF32BE_MARKER(Object? UTF32BE_MARKER) =>
      setAttribute("UTF32BE_MARKER", UTF32BE_MARKER);

  /// ## UTF32LE_MARKER (getter)
  Object? get UTF32LE_MARKER => getAttribute("UTF32LE_MARKER");

  /// ## UTF32LE_MARKER (setter)
  set UTF32LE_MARKER(Object? UTF32LE_MARKER) =>
      setAttribute("UTF32LE_MARKER", UTF32LE_MARKER);

  /// ## ZERO_BYTES (getter)
  Object? get ZERO_BYTES => getAttribute("ZERO_BYTES");

  /// ## ZERO_BYTES (setter)
  set ZERO_BYTES(Object? ZERO_BYTES) => setAttribute("ZERO_BYTES", ZERO_BYTES);

  /// ## chardet (getter)
  Null get chardet => getAttribute("chardet");

  /// ## chardet (setter)
  set chardet(Null chardet) => setAttribute("chardet", chardet);

  /// ## lazy_chardet_encoding (getter)
  Null get lazy_chardet_encoding => getAttribute("lazy_chardet_encoding");

  /// ## lazy_chardet_encoding (setter)
  set lazy_chardet_encoding(Null lazy_chardet_encoding) =>
      setAttribute("lazy_chardet_encoding", lazy_chardet_encoding);
}

/// ## exceptions
///
/// ### python source
/// ```py
/// # Exceptions used throughout feedparser
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
/// __all__ = [
///     'ThingsNobodyCaresAboutButMe',
///     'CharacterEncodingOverride',
///     'CharacterEncodingUnknown',
///     'NonXMLContentType',
///     'UndeclaredNamespace',
/// ]
///
///
/// class ThingsNobodyCaresAboutButMe(Exception):
///     pass
///
///
/// class CharacterEncodingOverride(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class CharacterEncodingUnknown(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
///
///
/// class UndeclaredNamespace(Exception):
///     pass
/// ```
final class exceptions extends PythonModule {
  exceptions.from(super.pythonModule) : super.from();

  static exceptions import() => PythonFfi.instance.importModule(
        "feedparser.exceptions",
        exceptions.from,
      );
}

/// ## html
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
/// import html.entities
/// import re
///
/// from .sgml import *
///
/// _cp1252 = {
///     128: '\u20ac',  # euro sign
///     130: '\u201a',  # single low-9 quotation mark
///     131: '\u0192',  # latin small letter f with hook
///     132: '\u201e',  # double low-9 quotation mark
///     133: '\u2026',  # horizontal ellipsis
///     134: '\u2020',  # dagger
///     135: '\u2021',  # double dagger
///     136: '\u02c6',  # modifier letter circumflex accent
///     137: '\u2030',  # per mille sign
///     138: '\u0160',  # latin capital letter s with caron
///     139: '\u2039',  # single left-pointing angle quotation mark
///     140: '\u0152',  # latin capital ligature oe
///     142: '\u017d',  # latin capital letter z with caron
///     145: '\u2018',  # left single quotation mark
///     146: '\u2019',  # right single quotation mark
///     147: '\u201c',  # left double quotation mark
///     148: '\u201d',  # right double quotation mark
///     149: '\u2022',  # bullet
///     150: '\u2013',  # en dash
///     151: '\u2014',  # em dash
///     152: '\u02dc',  # small tilde
///     153: '\u2122',  # trade mark sign
///     154: '\u0161',  # latin small letter s with caron
///     155: '\u203a',  # single right-pointing angle quotation mark
///     156: '\u0153',  # latin small ligature oe
///     158: '\u017e',  # latin small letter z with caron
///     159: '\u0178',  # latin capital letter y with diaeresis
/// }
///
///
/// class _BaseHTMLProcessor(sgmllib.SGMLParser, object):
///     special = re.compile("""[<>'"]""")
///     bare_ampersand = re.compile(r"&(?!#\d+;|#x[0-9a-fA-F]+;|\w+;)")
///     elements_no_end_tag = {
///         'area',
///         'base',
///         'basefont',
///         'br',
///         'col',
///         'command',
///         'embed',
///         'frame',
///         'hr',
///         'img',
///         'input',
///         'isindex',
///         'keygen',
///         'link',
///         'meta',
///         'param',
///         'source',
///         'track',
///         'wbr',
///     }
///
///     def __init__(self, encoding=None, _type='application/xhtml+xml'):
///         if encoding:
///             self.encoding = encoding
///         self._type = _type
///         self.pieces = []
///         super(_BaseHTMLProcessor, self).__init__()
///
///     def reset(self):
///         self.pieces = []
///         super(_BaseHTMLProcessor, self).reset()
///
///     def _shorttag_replace(self, match):
///         """
///         :type match: Match[str]
///         :rtype: str
///         """
///
///         tag = match.group(1)
///         if tag in self.elements_no_end_tag:
///             return '<' + tag + ' />'
///         else:
///             return '<' + tag + '></' + tag + '>'
///
///     # By declaring these methods and overriding their compiled code
///     # with the code from sgmllib, the original code will execute in
///     # feedparser's scope instead of sgmllib's. This means that the
///     # `tagfind` and `charref` regular expressions will be found as
///     # they're declared above, not as they're declared in sgmllib.
///     def goahead(self, i):
///         raise NotImplementedError
///
///     # Replace goahead with SGMLParser's goahead() code object.
///     try:
///         goahead.__code__ = sgmllib.SGMLParser.goahead.__code__
///     except AttributeError:
///         # Python 2
///         # noinspection PyUnresolvedReferences
///         goahead.func_code = sgmllib.SGMLParser.goahead.func_code
///
///     def __parse_starttag(self, i):
///         raise NotImplementedError
///
///     # Replace __parse_starttag with SGMLParser's parse_starttag() code object.
///     try:
///         __parse_starttag.__code__ = sgmllib.SGMLParser.parse_starttag.__code__
///     except AttributeError:
///         # Python 2
///         # noinspection PyUnresolvedReferences
///         __parse_starttag.func_code = sgmllib.SGMLParser.parse_starttag.func_code
///
///     def parse_starttag(self, i):
///         j = self.__parse_starttag(i)
///         if self._type == 'application/xhtml+xml':
///             if j > 2 and self.rawdata[j-2:j] == '/>':
///                 self.unknown_endtag(self.lasttag)
///         return j
///
///     def feed(self, data):
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
///
///     @staticmethod
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
///
///     def unknown_starttag(self, tag, attrs):
///         """
///         :type tag: str
///         :type attrs: List[Tuple[str, str]]
///         :rtype: None
///         """
///
///         # Called for each start tag
///         # attrs is a list of (attr, value) tuples
///         # e.g. for <pre class='screen'>, tag='pre', attrs=[('class', 'screen')]
///         uattrs = []
///         strattrs = ''
///         if attrs:
///             for key, value in attrs:
///                 value = value.replace('>', '&gt;')
///                 value = value.replace('<', '&lt;')
///                 value = value.replace('"', '&quot;')
///                 value = self.bare_ampersand.sub("&amp;", value)
///                 uattrs.append((key, value))
///             strattrs = ''.join(
///                 ' %s="%s"' % (key, value)
///                 for key, value in uattrs
///             )
///         if tag in self.elements_no_end_tag:
///             self.pieces.append('<%s%s />' % (tag, strattrs))
///         else:
///             self.pieces.append('<%s%s>' % (tag, strattrs))
///
///     def unknown_endtag(self, tag):
///         """
///         :type tag: str
///         :rtype: None
///         """
///
///         # Called for each end tag, e.g. for </pre>, tag will be 'pre'
///         # Reconstruct the original end tag.
///         if tag not in self.elements_no_end_tag:
///             self.pieces.append("</%s>" % tag)
///
///     def handle_charref(self, ref):
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
///
///     def handle_entityref(self, ref):
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
///
///     def handle_data(self, text):
///         """
///         :type text: str
///         :rtype: None
///         """
///
///         # called for each block of plain text, i.e. outside of any tag and
///         # not containing any character or entity references
///         # Store the original text verbatim.
///         self.pieces.append(text)
///
///     def handle_comment(self, text):
///         """
///         :type text: str
///         :rtype: None
///         """
///
///         # Called for HTML comments, e.g. <!-- insert Javascript code here -->
///         # Reconstruct the original comment.
///         self.pieces.append('<!--%s-->' % text)
///
///     def handle_pi(self, text):
///         """
///         :type text: str
///         :rtype: None
///         """
///
///         # Called for each processing instruction, e.g. <?instruction>
///         # Reconstruct original processing instruction.
///         self.pieces.append('<?%s>' % text)
///
///     def handle_decl(self, text):
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
///
///     _new_declname_match = re.compile(r'[a-zA-Z][-_.a-zA-Z0-9:]*\s*').match
///
///     def _scan_name(self, i, declstartpos):
///         """
///         :type i: int
///         :type declstartpos: int
///         :rtype: Tuple[Optional[str], int]
///         """
///
///         rawdata = self.rawdata
///         n = len(rawdata)
///         if i == n:
///             return None, -1
///         m = self._new_declname_match(rawdata, i)
///         if m:
///             s = m.group()
///             name = s.strip()
///             if (i + len(s)) == n:
///                 return None, -1  # end of buffer
///             return name.lower(), m.end()
///         else:
///             self.handle_data(rawdata)
///             # self.updatepos(declstartpos, i)
///             return None, -1
///
///     @staticmethod
///     def convert_charref(name):
///         """
///         :type name: str
///         :rtype: str
///         """
///
///         return '&#%s;' % name
///
///     @staticmethod
///     def convert_entityref(name):
///         """
///         :type name: str
///         :rtype: str
///         """
///
///         return '&%s;' % name
///
///     def output(self):
///         """Return processed HTML as a single string.
///
///         :rtype: str
///         """
///
///         return ''.join(self.pieces)
///
///     def parse_declaration(self, i):
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
final class html extends PythonModule {
  html.from(super.pythonModule) : super.from();

  static html import() => PythonFfi.instance.importModule(
        "feedparser.html",
        html.from,
      );
}

/// ## namespaces
final class namespaces extends PythonModule {
  namespaces.from(super.pythonModule) : super.from();

  static namespaces import() => PythonFfi.instance.importModule(
        "feedparser.namespaces",
        namespaces.from,
      );
}

/// ## parsers
final class parsers extends PythonModule {
  parsers.from(super.pythonModule) : super.from();

  static parsers import() => PythonFfi.instance.importModule(
        "feedparser.parsers",
        parsers.from,
      );
}

/// ## loose
///
/// ### python source
/// ```py
/// # The loose feed parser that interfaces with an SGML parsing library
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
/// class _LooseFeedParser(object):
///     contentparams = None
///
///     def __init__(self, baseuri=None, baselang=None, encoding=None, entities=None):
///         self.baseuri = baseuri or ''
///         self.lang = baselang or None
///         self.encoding = encoding or 'utf-8'  # character encoding
///         self.entities = entities or {}
///         super(_LooseFeedParser, self).__init__()
///
///     @staticmethod
///     def _normalize_attributes(kv):
///         k = kv[0].lower()
///         v = k in ('rel', 'type') and kv[1].lower() or kv[1]
///         # the sgml parser doesn't handle entities in attributes, nor
///         # does it pass the attribute values through as unicode, while
///         # strict xml parsers do -- account for this difference
///         v = v.replace('&amp;', '&')
///         return k, v
///
///     def decode_entities(self, element, data):
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
///
///     @staticmethod
///     def strattrs(attrs):
///         return ''.join(
///             ' %s="%s"' % (n, v.replace('"', '&quot;'))
///             for n, v in attrs
///         )
/// ```
final class loose extends PythonModule {
  loose.from(super.pythonModule) : super.from();

  static loose import() => PythonFfi.instance.importModule(
        "feedparser.parsers.loose",
        loose.from,
      );
}

/// ## strict
///
/// ### python source
/// ```py
/// # The strict feed parser that interfaces with an XML parsing library
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
/// from ..exceptions import UndeclaredNamespace
///
///
/// class _StrictFeedParser(object):
///     def __init__(self, baseuri, baselang, encoding):
///         self.bozo = 0
///         self.exc = None
///         self.decls = {}
///         self.baseuri = baseuri or ''
///         self.lang = baselang
///         self.encoding = encoding
///         super(_StrictFeedParser, self).__init__()
///
///     @staticmethod
///     def _normalize_attributes(kv):
///         k = kv[0].lower()
///         v = k in ('rel', 'type') and kv[1].lower() or kv[1]
///         return k, v
///
///     def startPrefixMapping(self, prefix, uri):
///         if not uri:
///             return
///         # Jython uses '' instead of None; standardize on None
///         prefix = prefix or None
///         self.track_namespace(prefix, uri)
///         if prefix and uri == 'http://www.w3.org/1999/xlink':
///             self.decls['xmlns:' + prefix] = uri
///
///     def startElementNS(self, name, qname, attrs):
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
///
///     def characters(self, text):
///         self.handle_data(text)
///
///     def endElementNS(self, name, qname):
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
///
///     def error(self, exc):
///         self.bozo = 1
///         self.exc = exc
///
///     # drv_libxml2 calls warning() in some cases
///     warning = error
///
///     def fatalError(self, exc):
///         self.error(exc)
///         raise exc
/// ```
final class strict extends PythonModule {
  strict.from(super.pythonModule) : super.from();

  static strict import() => PythonFfi.instance.importModule(
        "feedparser.parsers.strict",
        strict.from,
      );
}

/// ## sanitizer
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
/// from .html import _BaseHTMLProcessor
/// from .urls import make_safe_absolute_uri
///
///
/// class _HTMLSanitizer(_BaseHTMLProcessor):
///     acceptable_elements = {
///         'a',
///         'abbr',
///         'acronym',
///         'address',
///         'area',
///         'article',
///         'aside',
///         'audio',
///         'b',
///         'big',
///         'blockquote',
///         'br',
///         'button',
///         'canvas',
///         'caption',
///         'center',
///         'cite',
///         'code',
///         'col',
///         'colgroup',
///         'command',
///         'datagrid',
///         'datalist',
///         'dd',
///         'del',
///         'details',
///         'dfn',
///         'dialog',
///         'dir',
///         'div',
///         'dl',
///         'dt',
///         'em',
///         'event-source',
///         'fieldset',
///         'figcaption',
///         'figure',
///         'font',
///         'footer',
///         'form',
///         'h1',
///         'h2',
///         'h3',
///         'h4',
///         'h5',
///         'h6',
///         'header',
///         'hr',
///         'i',
///         'img',
///         'input',
///         'ins',
///         'kbd',
///         'keygen',
///         'label',
///         'legend',
///         'li',
///         'm',
///         'map',
///         'menu',
///         'meter',
///         'multicol',
///         'nav',
///         'nextid',
///         'noscript',
///         'ol',
///         'optgroup',
///         'option',
///         'output',
///         'p',
///         'pre',
///         'progress',
///         'q',
///         's',
///         'samp',
///         'section',
///         'select',
///         'small',
///         'sound',
///         'source',
///         'spacer',
///         'span',
///         'strike',
///         'strong',
///         'sub',
///         'sup',
///         'table',
///         'tbody',
///         'td',
///         'textarea',
///         'tfoot',
///         'th',
///         'thead',
///         'time',
///         'tr',
///         'tt',
///         'u',
///         'ul',
///         'var',
///         'video',
///     }
///
///     acceptable_attributes = {
///         'abbr',
///         'accept',
///         'accept-charset',
///         'accesskey',
///         'action',
///         'align',
///         'alt',
///         'autocomplete',
///         'autofocus',
///         'axis',
///         'background',
///         'balance',
///         'bgcolor',
///         'bgproperties',
///         'border',
///         'bordercolor',
///         'bordercolordark',
///         'bordercolorlight',
///         'bottompadding',
///         'cellpadding',
///         'cellspacing',
///         'ch',
///         'challenge',
///         'char',
///         'charoff',
///         'charset',
///         'checked',
///         'choff',
///         'cite',
///         'class',
///         'clear',
///         'color',
///         'cols',
///         'colspan',
///         'compact',
///         'contenteditable',
///         'controls',
///         'coords',
///         'data',
///         'datafld',
///         'datapagesize',
///         'datasrc',
///         'datetime',
///         'default',
///         'delay',
///         'dir',
///         'disabled',
///         'draggable',
///         'dynsrc',
///         'enctype',
///         'end',
///         'face',
///         'for',
///         'form',
///         'frame',
///         'galleryimg',
///         'gutter',
///         'headers',
///         'height',
///         'hidden',
///         'hidefocus',
///         'high',
///         'href',
///         'hreflang',
///         'hspace',
///         'icon',
///         'id',
///         'inputmode',
///         'ismap',
///         'keytype',
///         'label',
///         'lang',
///         'leftspacing',
///         'list',
///         'longdesc',
///         'loop',
///         'loopcount',
///         'loopend',
///         'loopstart',
///         'low',
///         'lowsrc',
///         'max',
///         'maxlength',
///         'media',
///         'method',
///         'min',
///         'multiple',
///         'name',
///         'nohref',
///         'noshade',
///         'nowrap',
///         'open',
///         'optimum',
///         'pattern',
///         'ping',
///         'point-size',
///         'poster',
///         'pqg',
///         'preload',
///         'prompt',
///         'radiogroup',
///         'readonly',
///         'rel',
///         'repeat-max',
///         'repeat-min',
///         'replace',
///         'required',
///         'rev',
///         'rightspacing',
///         'rows',
///         'rowspan',
///         'rules',
///         'scope',
///         'selected',
///         'shape',
///         'size',
///         'span',
///         'src',
///         'start',
///         'step',
///         'style',
///         'summary',
///         'suppress',
///         'tabindex',
///         'target',
///         'template',
///         'title',
///         'toppadding',
///         'type',
///         'unselectable',
///         'urn',
///         'usemap',
///         'valign',
///         'value',
///         'variable',
///         'volume',
///         'vrml',
///         'vspace',
///         'width',
///         'wrap',
///         'xml:lang',
///     }
///
///     unacceptable_elements_with_end_tag = {
///         'applet',
///         'script',
///         'style',
///     }
///
///     acceptable_css_properties = {
///         'azimuth',
///         'background-color',
///         'border-bottom-color',
///         'border-collapse',
///         'border-color',
///         'border-left-color',
///         'border-right-color',
///         'border-top-color',
///         'clear',
///         'color',
///         'cursor',
///         'direction',
///         'display',
///         'elevation',
///         'float',
///         'font',
///         'font-family',
///         'font-size',
///         'font-style',
///         'font-variant',
///         'font-weight',
///         'height',
///         'letter-spacing',
///         'line-height',
///         'overflow',
///         'pause',
///         'pause-after',
///         'pause-before',
///         'pitch',
///         'pitch-range',
///         'richness',
///         'speak',
///         'speak-header',
///         'speak-numeral',
///         'speak-punctuation',
///         'speech-rate',
///         'stress',
///         'text-align',
///         'text-decoration',
///         'text-indent',
///         'unicode-bidi',
///         'vertical-align',
///         'voice-family',
///         'volume',
///         'white-space',
///         'width',
///     }
///
///     # survey of common keywords found in feeds
///     acceptable_css_keywords = {
///         '!important',
///         'aqua',
///         'auto',
///         'black',
///         'block',
///         'blue',
///         'bold',
///         'both',
///         'bottom',
///         'brown',
///         'center',
///         'collapse',
///         'dashed',
///         'dotted',
///         'fuchsia',
///         'gray',
///         'green',
///         'italic',
///         'left',
///         'lime',
///         'maroon',
///         'medium',
///         'navy',
///         'none',
///         'normal',
///         'nowrap',
///         'olive',
///         'pointer',
///         'purple',
///         'red',
///         'right',
///         'silver',
///         'solid',
///         'teal',
///         'top',
///         'transparent',
///         'underline',
///         'white',
///         'yellow',
///     }
///
///     valid_css_values = re.compile(
///         r'^('
///         r'#[0-9a-f]+'  # Hex values
///         r'|rgb\(\d+%?,\d*%?,?\d*%?\)?'  # RGB values
///         r'|\d{0,2}\.?\d{0,2}(cm|em|ex|in|mm|pc|pt|px|%|,|\))?'  # Sizes/widths
///         r')$'
///     )
///
///     mathml_elements = {
///         'annotation',
///         'annotation-xml',
///         'maction',
///         'maligngroup',
///         'malignmark',
///         'math',
///         'menclose',
///         'merror',
///         'mfenced',
///         'mfrac',
///         'mglyph',
///         'mi',
///         'mlabeledtr',
///         'mlongdiv',
///         'mmultiscripts',
///         'mn',
///         'mo',
///         'mover',
///         'mpadded',
///         'mphantom',
///         'mprescripts',
///         'mroot',
///         'mrow',
///         'ms',
///         'mscarries',
///         'mscarry',
///         'msgroup',
///         'msline',
///         'mspace',
///         'msqrt',
///         'msrow',
///         'mstack',
///         'mstyle',
///         'msub',
///         'msubsup',
///         'msup',
///         'mtable',
///         'mtd',
///         'mtext',
///         'mtr',
///         'munder',
///         'munderover',
///         'none',
///         'semantics',
///     }
///
///     mathml_attributes = {
///         'accent',
///         'accentunder',
///         'actiontype',
///         'align',
///         'alignmentscope',
///         'altimg',
///         'altimg-height',
///         'altimg-valign',
///         'altimg-width',
///         'alttext',
///         'bevelled',
///         'charalign',
///         'close',
///         'columnalign',
///         'columnlines',
///         'columnspacing',
///         'columnspan',
///         'columnwidth',
///         'crossout',
///         'decimalpoint',
///         'denomalign',
///         'depth',
///         'dir',
///         'display',
///         'displaystyle',
///         'edge',
///         'encoding',
///         'equalcolumns',
///         'equalrows',
///         'fence',
///         'fontstyle',
///         'fontweight',
///         'form',
///         'frame',
///         'framespacing',
///         'groupalign',
///         'height',
///         'href',
///         'id',
///         'indentalign',
///         'indentalignfirst',
///         'indentalignlast',
///         'indentshift',
///         'indentshiftfirst',
///         'indentshiftlast',
///         'indenttarget',
///         'infixlinebreakstyle',
///         'largeop',
///         'length',
///         'linebreak',
///         'linebreakmultchar',
///         'linebreakstyle',
///         'lineleading',
///         'linethickness',
///         'location',
///         'longdivstyle',
///         'lquote',
///         'lspace',
///         'mathbackground',
///         'mathcolor',
///         'mathsize',
///         'mathvariant',
///         'maxsize',
///         'minlabelspacing',
///         'minsize',
///         'movablelimits',
///         'notation',
///         'numalign',
///         'open',
///         'other',
///         'overflow',
///         'position',
///         'rowalign',
///         'rowlines',
///         'rowspacing',
///         'rowspan',
///         'rquote',
///         'rspace',
///         'scriptlevel',
///         'scriptminsize',
///         'scriptsizemultiplier',
///         'selection',
///         'separator',
///         'separators',
///         'shift',
///         'side',
///         'src',
///         'stackalign',
///         'stretchy',
///         'subscriptshift',
///         'superscriptshift',
///         'symmetric',
///         'voffset',
///         'width',
///         'xlink:href',
///         'xlink:show',
///         'xlink:type',
///         'xmlns',
///         'xmlns:xlink',
///     }
///
///     # svgtiny - foreignObject + linearGradient + radialGradient + stop
///     svg_elements = {
///         'a',
///         'animate',
///         'animateColor',
///         'animateMotion',
///         'animateTransform',
///         'circle',
///         'defs',
///         'desc',
///         'ellipse',
///         'font-face',
///         'font-face-name',
///         'font-face-src',
///         'foreignObject',
///         'g',
///         'glyph',
///         'hkern',
///         'line',
///         'linearGradient',
///         'marker',
///         'metadata',
///         'missing-glyph',
///         'mpath',
///         'path',
///         'polygon',
///         'polyline',
///         'radialGradient',
///         'rect',
///         'set',
///         'stop',
///         'svg',
///         'switch',
///         'text',
///         'title',
///         'tspan',
///         'use',
///     }
///
///     # svgtiny + class + opacity + offset + xmlns + xmlns:xlink
///     svg_attributes = {
///         'accent-height',
///         'accumulate',
///         'additive',
///         'alphabetic',
///         'arabic-form',
///         'ascent',
///         'attributeName',
///         'attributeType',
///         'baseProfile',
///         'bbox',
///         'begin',
///         'by',
///         'calcMode',
///         'cap-height',
///         'class',
///         'color',
///         'color-rendering',
///         'content',
///         'cx',
///         'cy',
///         'd',
///         'descent',
///         'display',
///         'dur',
///         'dx',
///         'dy',
///         'end',
///         'fill',
///         'fill-opacity',
///         'fill-rule',
///         'font-family',
///         'font-size',
///         'font-stretch',
///         'font-style',
///         'font-variant',
///         'font-weight',
///         'from',
///         'fx',
///         'fy',
///         'g1',
///         'g2',
///         'glyph-name',
///         'gradientUnits',
///         'hanging',
///         'height',
///         'horiz-adv-x',
///         'horiz-origin-x',
///         'id',
///         'ideographic',
///         'k',
///         'keyPoints',
///         'keySplines',
///         'keyTimes',
///         'lang',
///         'marker-end',
///         'marker-mid',
///         'marker-start',
///         'markerHeight',
///         'markerUnits',
///         'markerWidth',
///         'mathematical',
///         'max',
///         'min',
///         'name',
///         'offset',
///         'opacity',
///         'orient',
///         'origin',
///         'overline-position',
///         'overline-thickness',
///         'panose-1',
///         'path',
///         'pathLength',
///         'points',
///         'preserveAspectRatio',
///         'r',
///         'refX',
///         'refY',
///         'repeatCount',
///         'repeatDur',
///         'requiredExtensions',
///         'requiredFeatures',
///         'restart',
///         'rotate',
///         'rx',
///         'ry',
///         'slope',
///         'stemh',
///         'stemv',
///         'stop-color',
///         'stop-opacity',
///         'strikethrough-position',
///         'strikethrough-thickness',
///         'stroke',
///         'stroke-dasharray',
///         'stroke-dashoffset',
///         'stroke-linecap',
///         'stroke-linejoin',
///         'stroke-miterlimit',
///         'stroke-opacity',
///         'stroke-width',
///         'systemLanguage',
///         'target',
///         'text-anchor',
///         'to',
///         'transform',
///         'type',
///         'u1',
///         'u2',
///         'underline-position',
///         'underline-thickness',
///         'unicode',
///         'unicode-range',
///         'units-per-em',
///         'values',
///         'version',
///         'viewBox',
///         'visibility',
///         'width',
///         'widths',
///         'x',
///         'x-height',
///         'x1',
///         'x2',
///         'xlink:actuate',
///         'xlink:arcrole',
///         'xlink:href',
///         'xlink:role',
///         'xlink:show',
///         'xlink:title',
///         'xlink:type',
///         'xml:base',
///         'xml:lang',
///         'xml:space',
///         'xmlns',
///         'xmlns:xlink',
///         'y',
///         'y1',
///         'y2',
///         'zoomAndPan',
///     }
///
///     svg_attr_map = None
///     svg_elem_map = None
///
///     acceptable_svg_properties = {
///         'fill',
///         'fill-opacity',
///         'fill-rule',
///         'stroke',
///         'stroke-linecap',
///         'stroke-linejoin',
///         'stroke-opacity',
///         'stroke-width',
///     }
///
///     def __init__(self, encoding=None, _type='application/xhtml+xml'):
///         super(_HTMLSanitizer, self).__init__(encoding, _type)
///
///         self.unacceptablestack = 0
///         self.mathmlOK = 0
///         self.svgOK = 0
///
///     def reset(self):
///         super(_HTMLSanitizer, self).reset()
///         self.unacceptablestack = 0
///         self.mathmlOK = 0
///         self.svgOK = 0
///
///     def unknown_starttag(self, tag, attrs):
///         acceptable_attributes = self.acceptable_attributes
///         keymap = {}
///         if tag not in self.acceptable_elements or self.svgOK:
///             if tag in self.unacceptable_elements_with_end_tag:
///                 self.unacceptablestack += 1
///
///             # add implicit namespaces to html5 inline svg/mathml
///             if self._type.endswith('html'):
///                 if not dict(attrs).get('xmlns'):
///                     if tag == 'svg':
///                         attrs.append(('xmlns', 'http://www.w3.org/2000/svg'))
///                     if tag == 'math':
///                         attrs.append(('xmlns', 'http://www.w3.org/1998/Math/MathML'))
///
///             # not otherwise acceptable, perhaps it is MathML or SVG?
///             if tag == 'math' and ('xmlns', 'http://www.w3.org/1998/Math/MathML') in attrs:
///                 self.mathmlOK += 1
///             if tag == 'svg' and ('xmlns', 'http://www.w3.org/2000/svg') in attrs:
///                 self.svgOK += 1
///
///             # chose acceptable attributes based on tag class, else bail
///             if self.mathmlOK and tag in self.mathml_elements:
///                 acceptable_attributes = self.mathml_attributes
///             elif self.svgOK and tag in self.svg_elements:
///                 # For most vocabularies, lowercasing is a good idea. Many
///                 # svg elements, however, are camel case.
///                 if not self.svg_attr_map:
///                     lower = [attr.lower() for attr in self.svg_attributes]
///                     mix = [a for a in self.svg_attributes if a not in lower]
///                     self.svg_attributes = lower
///                     self.svg_attr_map = {a.lower(): a for a in mix}
///
///                     lower = [attr.lower() for attr in self.svg_elements]
///                     mix = [a for a in self.svg_elements if a not in lower]
///                     self.svg_elements = lower
///                     self.svg_elem_map = {a.lower(): a for a in mix}
///                 acceptable_attributes = self.svg_attributes
///                 tag = self.svg_elem_map.get(tag, tag)
///                 keymap = self.svg_attr_map
///             elif tag not in self.acceptable_elements:
///                 return
///
///         # declare xlink namespace, if needed
///         if self.mathmlOK or self.svgOK:
///             if any((a for a in attrs if a[0].startswith('xlink:'))):
///                 if not ('xmlns:xlink', 'http://www.w3.org/1999/xlink') in attrs:
///                     attrs.append(('xmlns:xlink', 'http://www.w3.org/1999/xlink'))
///
///         clean_attrs = []
///         for key, value in self.normalize_attrs(attrs):
///             if key == 'style' and 'style' in acceptable_attributes:
///                 clean_value = self.sanitize_style(value)
///                 if clean_value:
///                     clean_attrs.append((key, clean_value))
///             elif key in acceptable_attributes:
///                 key = keymap.get(key, key)
///                 # make sure the uri uses an acceptable uri scheme
///                 if key == 'href':
///                     value = make_safe_absolute_uri(value)
///                 clean_attrs.append((key, value))
///         super(_HTMLSanitizer, self).unknown_starttag(tag, clean_attrs)
///
///     def unknown_endtag(self, tag):
///         if tag not in self.acceptable_elements:
///             if tag in self.unacceptable_elements_with_end_tag:
///                 self.unacceptablestack -= 1
///             if self.mathmlOK and tag in self.mathml_elements:
///                 if tag == 'math' and self.mathmlOK:
///                     self.mathmlOK -= 1
///             elif self.svgOK and tag in self.svg_elements:
///                 tag = self.svg_elem_map.get(tag, tag)
///                 if tag == 'svg' and self.svgOK:
///                     self.svgOK -= 1
///             else:
///                 return
///         super(_HTMLSanitizer, self).unknown_endtag(tag)
///
///     def handle_pi(self, text):
///         pass
///
///     def handle_decl(self, text):
///         pass
///
///     def handle_data(self, text):
///         if not self.unacceptablestack:
///             super(_HTMLSanitizer, self).handle_data(text)
///
///     def sanitize_style(self, style):
///         # disallow urls
///         style = re.compile(r'url\s*\(\s*[^\s)]+?\s*\)\s*').sub(' ', style)
///
///         # gauntlet
///         if not re.match(r"""^([:,;#%.\sa-zA-Z0-9!]|\w-\w|'[\s\w]+'|"[\s\w]+"|\([\d,\s]+\))*$""", style):
///             return ''
///         # This replaced a regexp that used re.match and was prone to
///         # pathological back-tracking.
///         if re.sub(r"\s*[-\w]+\s*:\s*[^:;]*;?", '', style).strip():
///             return ''
///
///         clean = []
///         for prop, value in re.findall(r"([-\w]+)\s*:\s*([^:;]*)", style):
///             if not value:
///                 continue
///             if prop.lower() in self.acceptable_css_properties:
///                 clean.append(prop + ': ' + value + ';')
///             elif prop.split('-')[0].lower() in ['background', 'border', 'margin', 'padding']:
///                 for keyword in value.split():
///                     if (
///                             keyword not in self.acceptable_css_keywords
///                             and not self.valid_css_values.match(keyword)
///                     ):
///                         break
///                 else:
///                     clean.append(prop + ': ' + value + ';')
///             elif self.svgOK and prop.lower() in self.acceptable_svg_properties:
///                 clean.append(prop + ': ' + value + ';')
///
///         return ' '.join(clean)
///
///     def parse_comment(self, i, report=1):
///         ret = super(_HTMLSanitizer, self).parse_comment(i, report)
///         if ret >= 0:
///             return ret
///         # if ret == -1, this may be a malicious attempt to circumvent
///         # sanitization, or a page-destroying unclosed comment
///         match = re.compile(r'--[^>]*>').search(self.rawdata, i+4)
///         if match:
///             return match.end()
///         # unclosed comment; deliberately fail to handle_data()
///         return len(self.rawdata)
///
///
/// def _sanitize_html(html_source, encoding, _type):
///     p = _HTMLSanitizer(encoding, _type)
///     html_source = html_source.replace('<![CDATA[', '&lt;![CDATA[')
///     p.feed(html_source)
///     data = p.output()
///     data = data.strip().replace('\r\n', '\n')
///     return data
///
///
/// # Match XML entity declarations.
/// # Example: <!ENTITY copyright "(C)">
/// RE_ENTITY_PATTERN = re.compile(br'^\s*<!ENTITY([^>]*?)>', re.MULTILINE)
///
/// # Match XML DOCTYPE declarations.
/// # Example: <!DOCTYPE feed [ ]>
/// RE_DOCTYPE_PATTERN = re.compile(br'^\s*<!DOCTYPE([^>]*?)>', re.MULTILINE)
///
/// # Match safe entity declarations.
/// # This will allow hexadecimal character references through,
/// # as well as text, but not arbitrary nested entities.
/// # Example: cubed "&#179;"
/// # Example: copyright "(C)"
/// # Forbidden: explode1 "&explode2;&explode2;"
/// RE_SAFE_ENTITY_PATTERN = re.compile(br'\s+(\w+)\s+"(&#\w+;|[^&"]*)"')
///
///
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
final class sanitizer extends PythonModule {
  sanitizer.from(super.pythonModule) : super.from();

  static sanitizer import() => PythonFfi.instance.importModule(
        "feedparser.sanitizer",
        sanitizer.from,
      );
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

  static sgml import() => PythonFfi.instance.importModule(
        "feedparser.sgml",
        sgml.from,
      );
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

  static urls import() => PythonFfi.instance.importModule(
        "feedparser.urls",
        urls.from,
      );

  /// ## ACCEPTABLE_URI_SCHEMES (getter)
  Object? get ACCEPTABLE_URI_SCHEMES => getAttribute("ACCEPTABLE_URI_SCHEMES");

  /// ## ACCEPTABLE_URI_SCHEMES (setter)
  set ACCEPTABLE_URI_SCHEMES(Object? ACCEPTABLE_URI_SCHEMES) =>
      setAttribute("ACCEPTABLE_URI_SCHEMES", ACCEPTABLE_URI_SCHEMES);
}
