// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library iso8601;

import "package:python_ffi_dart/python_ffi_dart.dart";

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
  factory struct_time() => PythonFfiDart.instance.importClass(
        "feedparser.datetimes.iso8601",
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

  static iso8601 import() => PythonFfiDart.instance.importModule(
        "feedparser.datetimes.iso8601",
        iso8601.from,
      );

  /// ## time
  time get $time => time.import();
}

/// ## time
final class time extends PythonModule {
  time.from(super.pythonModule) : super.from();

  static time import() => PythonFfiDart.instance.importModule(
        "feedparser.datetimes.time",
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
