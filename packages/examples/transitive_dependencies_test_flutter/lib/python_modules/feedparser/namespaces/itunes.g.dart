// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library itunes;

import "package:python_ffi/python_ffi.dart";

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
        "feedparser.namespaces.itunes",
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

/// ## Namespace
///
/// ### python source
/// ```py
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
final class Namespace extends PythonClass {
  factory Namespace() => PythonFfi.instance.importClass(
        "feedparser.namespaces.itunes",
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
