// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library dc;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
        "feedparser.namespaces.dc",
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
final class Namespace extends PythonClass {
  factory Namespace() => PythonFfiDart.instance.importClass(
        "feedparser.namespaces.dc",
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
