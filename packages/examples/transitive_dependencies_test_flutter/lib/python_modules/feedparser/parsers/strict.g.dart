// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library strict;

import "package:python_ffi/python_ffi.dart";

/// ## UndeclaredNamespace
///
/// ### python source
/// ```py
/// class UndeclaredNamespace(Exception):
///     pass
/// ```
final class UndeclaredNamespace extends PythonClass {
  factory UndeclaredNamespace() => PythonFfi.instance.importClass(
        "feedparser.parsers.strict",
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
