// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library $mixin;

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
        "feedparser.mixin",
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

/// ## Error
final class Error extends PythonClass {
  factory Error() => PythonFfiDart.instance.importClass(
        "feedparser.mixin",
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
        "feedparser.mixin",
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
        "feedparser.mixin",
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

  /// ## binascii
  binascii get $binascii => binascii.import();

  /// ## cc
  cc get $cc => cc.import();

  /// ## dc
  dc get $dc => dc.import();

  /// ## georss
  georss get $georss => georss.import();

  /// ## itunes
  itunes get $itunes => itunes.import();

  /// ## mediarss
  mediarss get $mediarss => mediarss.import();

  /// ## psc
  psc get $psc => psc.import();
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
