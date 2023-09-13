// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library datetimes;

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
        "feedparser.datetimes",
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

  static datetimes import() => PythonFfiDart.instance.importModule(
        "feedparser.datetimes",
        datetimes.from,
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

  /// ## asctime
  asctime get $asctime => asctime.import();

  /// ## greek
  greek get $greek => greek.import();

  /// ## hungarian
  hungarian get $hungarian => hungarian.import();

  /// ## iso8601
  iso8601 get $iso8601 => iso8601.import();

  /// ## korean
  korean get $korean => korean.import();

  /// ## perforce
  perforce get $perforce => perforce.import();

  /// ## rfc822
  rfc822 get $rfc822 => rfc822.import();

  /// ## w3dtf
  w3dtf get $w3dtf => w3dtf.import();
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

  static asctime import() => PythonFfiDart.instance.importModule(
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

  static greek import() => PythonFfiDart.instance.importModule(
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

  static hungarian import() => PythonFfiDart.instance.importModule(
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

  static iso8601 import() => PythonFfiDart.instance.importModule(
        "feedparser.datetimes.iso8601",
        iso8601.from,
      );
}

/// ## time
final class time extends PythonModule {
  time.from(super.pythonModule) : super.from();

  static time import() => PythonFfiDart.instance.importModule(
        "feedparser.time",
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

  static korean import() => PythonFfiDart.instance.importModule(
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

  static perforce import() => PythonFfiDart.instance.importModule(
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

  static rfc822 import() => PythonFfiDart.instance.importModule(
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

  static w3dtf import() => PythonFfiDart.instance.importModule(
        "feedparser.datetimes.w3dtf",
        w3dtf.from,
      );

  /// ## timezonenames (getter)
  Object? get timezonenames => getAttribute("timezonenames");

  /// ## timezonenames (setter)
  set timezonenames(Object? timezonenames) =>
      setAttribute("timezonenames", timezonenames);
}
