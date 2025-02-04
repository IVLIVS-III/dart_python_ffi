// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library encodings;

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
        "feedparser.encodings",
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
        "feedparser.encodings",
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

/// ## NonXMLContentType
///
/// ### python source
/// ```py
/// class NonXMLContentType(ThingsNobodyCaresAboutButMe):
///     pass
/// ```
final class NonXMLContentType extends PythonClass {
  factory NonXMLContentType() => PythonFfiDart.instance.importClass(
        "feedparser.encodings",
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

  static encodings import() => PythonFfiDart.instance.importModule(
        "feedparser.encodings",
        encodings.from,
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

  /// ## RE_XML_DECLARATION (getter)
  Object? get RE_XML_DECLARATION => getAttribute("RE_XML_DECLARATION");

  /// ## RE_XML_DECLARATION (setter)
  set RE_XML_DECLARATION(Object? RE_XML_DECLARATION) =>
      setAttribute("RE_XML_DECLARATION", RE_XML_DECLARATION);

  /// ## RE_XML_PI_ENCODING (getter)
  Object? get RE_XML_PI_ENCODING => getAttribute("RE_XML_PI_ENCODING");

  /// ## RE_XML_PI_ENCODING (setter)
  set RE_XML_PI_ENCODING(Object? RE_XML_PI_ENCODING) =>
      setAttribute("RE_XML_PI_ENCODING", RE_XML_PI_ENCODING);

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
