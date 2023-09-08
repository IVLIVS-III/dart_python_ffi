// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library pytimeparse;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## charbuffertype
final class charbuffertype extends PythonClass {
  factory charbuffertype() => PythonFfiDart.instance.importClass(
        "pytimeparse",
        "charbuffertype",
        charbuffertype.from,
        <Object?>[],
      );

  charbuffertype.from(super.pythonClass) : super.from();

  /// ## capitalize (getter)
  Object? get capitalize => getAttribute("capitalize");

  /// ## capitalize (setter)
  set capitalize(Object? capitalize) => setAttribute("capitalize", capitalize);

  /// ## casefold (getter)
  Object? get casefold => getAttribute("casefold");

  /// ## casefold (setter)
  set casefold(Object? casefold) => setAttribute("casefold", casefold);

  /// ## center (getter)
  Object? get center => getAttribute("center");

  /// ## center (setter)
  set center(Object? center) => setAttribute("center", center);

  /// ## count (getter)
  Object? get count => getAttribute("count");

  /// ## count (setter)
  set count(Object? count) => setAttribute("count", count);

  /// ## encode (getter)
  Object? get encode => getAttribute("encode");

  /// ## encode (setter)
  set encode(Object? encode) => setAttribute("encode", encode);

  /// ## endswith (getter)
  Object? get endswith => getAttribute("endswith");

  /// ## endswith (setter)
  set endswith(Object? endswith) => setAttribute("endswith", endswith);

  /// ## expandtabs (getter)
  Object? get expandtabs => getAttribute("expandtabs");

  /// ## expandtabs (setter)
  set expandtabs(Object? expandtabs) => setAttribute("expandtabs", expandtabs);

  /// ## find (getter)
  Object? get find => getAttribute("find");

  /// ## find (setter)
  set find(Object? find) => setAttribute("find", find);

  /// ## format (getter)
  Object? get format => getAttribute("format");

  /// ## format (setter)
  set format(Object? format) => setAttribute("format", format);

  /// ## format_map (getter)
  Object? get format_map => getAttribute("format_map");

  /// ## format_map (setter)
  set format_map(Object? format_map) => setAttribute("format_map", format_map);

  /// ## index (getter)
  Object? get index => getAttribute("index");

  /// ## index (setter)
  set index(Object? index) => setAttribute("index", index);

  /// ## isalnum (getter)
  Object? get isalnum => getAttribute("isalnum");

  /// ## isalnum (setter)
  set isalnum(Object? isalnum) => setAttribute("isalnum", isalnum);

  /// ## isalpha (getter)
  Object? get isalpha => getAttribute("isalpha");

  /// ## isalpha (setter)
  set isalpha(Object? isalpha) => setAttribute("isalpha", isalpha);

  /// ## isascii (getter)
  Object? get isascii => getAttribute("isascii");

  /// ## isascii (setter)
  set isascii(Object? isascii) => setAttribute("isascii", isascii);

  /// ## isdecimal (getter)
  Object? get isdecimal => getAttribute("isdecimal");

  /// ## isdecimal (setter)
  set isdecimal(Object? isdecimal) => setAttribute("isdecimal", isdecimal);

  /// ## isdigit (getter)
  Object? get isdigit => getAttribute("isdigit");

  /// ## isdigit (setter)
  set isdigit(Object? isdigit) => setAttribute("isdigit", isdigit);

  /// ## isidentifier (getter)
  Object? get isidentifier => getAttribute("isidentifier");

  /// ## isidentifier (setter)
  set isidentifier(Object? isidentifier) =>
      setAttribute("isidentifier", isidentifier);

  /// ## islower (getter)
  Object? get islower => getAttribute("islower");

  /// ## islower (setter)
  set islower(Object? islower) => setAttribute("islower", islower);

  /// ## isnumeric (getter)
  Object? get isnumeric => getAttribute("isnumeric");

  /// ## isnumeric (setter)
  set isnumeric(Object? isnumeric) => setAttribute("isnumeric", isnumeric);

  /// ## isprintable (getter)
  Object? get isprintable => getAttribute("isprintable");

  /// ## isprintable (setter)
  set isprintable(Object? isprintable) =>
      setAttribute("isprintable", isprintable);

  /// ## isspace (getter)
  Object? get isspace => getAttribute("isspace");

  /// ## isspace (setter)
  set isspace(Object? isspace) => setAttribute("isspace", isspace);

  /// ## istitle (getter)
  Object? get istitle => getAttribute("istitle");

  /// ## istitle (setter)
  set istitle(Object? istitle) => setAttribute("istitle", istitle);

  /// ## isupper (getter)
  Object? get isupper => getAttribute("isupper");

  /// ## isupper (setter)
  set isupper(Object? isupper) => setAttribute("isupper", isupper);

  /// ## join (getter)
  Object? get join => getAttribute("join");

  /// ## join (setter)
  set join(Object? join) => setAttribute("join", join);

  /// ## ljust (getter)
  Object? get ljust => getAttribute("ljust");

  /// ## ljust (setter)
  set ljust(Object? ljust) => setAttribute("ljust", ljust);

  /// ## lower (getter)
  Object? get lower => getAttribute("lower");

  /// ## lower (setter)
  set lower(Object? lower) => setAttribute("lower", lower);

  /// ## lstrip (getter)
  Object? get lstrip => getAttribute("lstrip");

  /// ## lstrip (setter)
  set lstrip(Object? lstrip) => setAttribute("lstrip", lstrip);

  /// ## partition (getter)
  Object? get partition => getAttribute("partition");

  /// ## partition (setter)
  set partition(Object? partition) => setAttribute("partition", partition);

  /// ## removeprefix (getter)
  Object? get removeprefix => getAttribute("removeprefix");

  /// ## removeprefix (setter)
  set removeprefix(Object? removeprefix) =>
      setAttribute("removeprefix", removeprefix);

  /// ## removesuffix (getter)
  Object? get removesuffix => getAttribute("removesuffix");

  /// ## removesuffix (setter)
  set removesuffix(Object? removesuffix) =>
      setAttribute("removesuffix", removesuffix);

  /// ## replace (getter)
  Object? get replace => getAttribute("replace");

  /// ## replace (setter)
  set replace(Object? replace) => setAttribute("replace", replace);

  /// ## rfind (getter)
  Object? get rfind => getAttribute("rfind");

  /// ## rfind (setter)
  set rfind(Object? rfind) => setAttribute("rfind", rfind);

  /// ## rindex (getter)
  Object? get rindex => getAttribute("rindex");

  /// ## rindex (setter)
  set rindex(Object? rindex) => setAttribute("rindex", rindex);

  /// ## rjust (getter)
  Object? get rjust => getAttribute("rjust");

  /// ## rjust (setter)
  set rjust(Object? rjust) => setAttribute("rjust", rjust);

  /// ## rpartition (getter)
  Object? get rpartition => getAttribute("rpartition");

  /// ## rpartition (setter)
  set rpartition(Object? rpartition) => setAttribute("rpartition", rpartition);

  /// ## rsplit (getter)
  Object? get rsplit => getAttribute("rsplit");

  /// ## rsplit (setter)
  set rsplit(Object? rsplit) => setAttribute("rsplit", rsplit);

  /// ## rstrip (getter)
  Object? get rstrip => getAttribute("rstrip");

  /// ## rstrip (setter)
  set rstrip(Object? rstrip) => setAttribute("rstrip", rstrip);

  /// ## split (getter)
  Object? get split => getAttribute("split");

  /// ## split (setter)
  set split(Object? split) => setAttribute("split", split);

  /// ## splitlines (getter)
  Object? get splitlines => getAttribute("splitlines");

  /// ## splitlines (setter)
  set splitlines(Object? splitlines) => setAttribute("splitlines", splitlines);

  /// ## startswith (getter)
  Object? get startswith => getAttribute("startswith");

  /// ## startswith (setter)
  set startswith(Object? startswith) => setAttribute("startswith", startswith);

  /// ## strip (getter)
  Object? get strip => getAttribute("strip");

  /// ## strip (setter)
  set strip(Object? strip) => setAttribute("strip", strip);

  /// ## swapcase (getter)
  Object? get swapcase => getAttribute("swapcase");

  /// ## swapcase (setter)
  set swapcase(Object? swapcase) => setAttribute("swapcase", swapcase);

  /// ## title (getter)
  Object? get title => getAttribute("title");

  /// ## title (setter)
  set title(Object? title) => setAttribute("title", title);

  /// ## translate (getter)
  Object? get translate => getAttribute("translate");

  /// ## translate (setter)
  set translate(Object? translate) => setAttribute("translate", translate);

  /// ## upper (getter)
  Object? get upper => getAttribute("upper");

  /// ## upper (setter)
  set upper(Object? upper) => setAttribute("upper", upper);

  /// ## zfill (getter)
  Object? get zfill => getAttribute("zfill");

  /// ## zfill (setter)
  set zfill(Object? zfill) => setAttribute("zfill", zfill);
}

/// ## pytimeparse
///
/// ### python docstring
///
/// __init__.py
/// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
///
/// `timeparse` module.
///
/// ### python source
/// ```py
/// #!/usr/bin/env python
/// # -*- coding: utf-8 -*-
///
/// '''
/// __init__.py
/// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
///
/// `timeparse` module.
/// '''
///
/// from __future__ import absolute_import
/// from codecs import open
/// from os import path
///
/// # Version. For each new release, the version number should be updated
/// # in the file VERSION.
/// try:
///     # If a VERSION file exists, use it!
///     with open(path.join(path.dirname(__file__), 'VERSION'),
///               encoding='utf-8') as infile:
///         __version__ = infile.read().strip()
/// except NameError:
///     __version__ = 'unknown (running code interactively?)'
/// except IOError as ex:
///     __version__ = "unknown (%s)" % ex
///
/// # import top-level functionality
/// from .timeparse import timeparse as parse
/// ```
final class pytimeparse extends PythonModule {
  pytimeparse.from(super.pythonModule) : super.from();

  static pytimeparse import() => PythonFfiDart.instance.importModule(
        "pytimeparse",
        pytimeparse.from,
      );

  /// ## open
  ///
  /// ### python docstring
  ///
  /// Open an encoded file using the given mode and return
  /// a wrapped version providing transparent encoding/decoding.
  ///
  /// Note: The wrapped version will only accept the object format
  /// defined by the codecs, i.e. Unicode objects for most builtin
  /// codecs. Output is also codec dependent and will usually be
  /// Unicode as well.
  ///
  /// If encoding is not None, then the
  /// underlying encoded files are always opened in binary mode.
  /// The default file mode is 'r', meaning to open the file in read mode.
  ///
  /// encoding specifies the encoding which is to be used for the
  /// file.
  ///
  /// errors may be given to define the error handling. It defaults
  /// to 'strict' which causes ValueErrors to be raised in case an
  /// encoding error occurs.
  ///
  /// buffering has the same meaning as for the builtin open() API.
  /// It defaults to -1 which means that the default buffer size will
  /// be used.
  ///
  /// The returned wrapped file object provides an extra attribute
  /// .encoding which allows querying the used encoding. This
  /// attribute is only available if an encoding was specified as
  /// parameter.
  Object? open({
    required Object? filename,
    Object? mode = "r",
    Object? encoding,
    Object? errors = "strict",
    Object? buffering = -1,
  }) =>
      getFunction("open").call(
        <Object?>[
          filename,
          mode,
          encoding,
          errors,
          buffering,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## parse
  ///
  /// ### python docstring
  ///
  /// Parse a time expression, returning it as a number of seconds.  If
  /// possible, the return value will be an `int`; if this is not
  /// possible, the return will be a `float`.  Returns `None` if a time
  /// expression cannot be parsed from the given string.
  ///
  /// Arguments:
  /// - `sval`: the string value to parse
  ///
  /// >>> timeparse('1:24')
  /// 84
  /// >>> timeparse(':22')
  /// 22
  /// >>> timeparse('1 minute, 24 secs')
  /// 84
  /// >>> timeparse('1m24s')
  /// 84
  /// >>> timeparse('1.2 minutes')
  /// 72
  /// >>> timeparse('1.2 seconds')
  /// 1.2
  ///
  /// Time expressions can be signed.
  ///
  /// >>> timeparse('- 1 minute')
  /// -60
  /// >>> timeparse('+ 1 minute')
  /// 60
  ///
  /// If granularity is specified as ``minutes``, then ambiguous digits following
  /// a colon will be interpreted as minutes; otherwise they are considered seconds.
  ///
  /// >>> timeparse('1:30')
  /// 90
  /// >>> timeparse('1:30', granularity='minutes')
  /// 5400
  ///
  /// ### python source
  /// ```py
  /// def timeparse(sval, granularity='seconds'):
  ///     '''
  ///     Parse a time expression, returning it as a number of seconds.  If
  ///     possible, the return value will be an `int`; if this is not
  ///     possible, the return will be a `float`.  Returns `None` if a time
  ///     expression cannot be parsed from the given string.
  ///
  ///     Arguments:
  ///     - `sval`: the string value to parse
  ///
  ///     >>> timeparse('1:24')
  ///     84
  ///     >>> timeparse(':22')
  ///     22
  ///     >>> timeparse('1 minute, 24 secs')
  ///     84
  ///     >>> timeparse('1m24s')
  ///     84
  ///     >>> timeparse('1.2 minutes')
  ///     72
  ///     >>> timeparse('1.2 seconds')
  ///     1.2
  ///
  ///     Time expressions can be signed.
  ///
  ///     >>> timeparse('- 1 minute')
  ///     -60
  ///     >>> timeparse('+ 1 minute')
  ///     60
  ///
  ///     If granularity is specified as ``minutes``, then ambiguous digits following
  ///     a colon will be interpreted as minutes; otherwise they are considered seconds.
  ///
  ///     >>> timeparse('1:30')
  ///     90
  ///     >>> timeparse('1:30', granularity='minutes')
  ///     5400
  ///     '''
  ///     match = COMPILED_SIGN.match(sval)
  ///     sign = -1 if match.groupdict()['sign'] == '-' else 1
  ///     sval = match.groupdict()['unsigned']
  ///     for timefmt in COMPILED_TIMEFORMATS:
  ///         match = timefmt.match(sval)
  ///         if match and match.group(0).strip():
  ///             mdict = match.groupdict()
  ///             if granularity == 'minutes':
  ///                 mdict = _interpret_as_minutes(sval, mdict)
  ///             # if all of the fields are integer numbers
  ///             if all(v.isdigit() for v in list(mdict.values()) if v):
  ///                 return sign * sum([MULTIPLIERS[k] * int(v, 10) for (k, v) in
  ///                             list(mdict.items()) if v is not None])
  ///             # if SECS is an integer number
  ///             elif ('secs' not in mdict or
  ///                   mdict['secs'] is None or
  ///                   mdict['secs'].isdigit()):
  ///                 # we will return an integer
  ///                 return (
  ///                     sign * int(sum([MULTIPLIERS[k] * float(v) for (k, v) in
  ///                              list(mdict.items()) if k != 'secs' and v is not None])) +
  ///                     (int(mdict['secs'], 10) if mdict['secs'] else 0))
  ///             else:
  ///                 # SECS is a float, we will return a float
  ///                 return sign * sum([MULTIPLIERS[k] * float(v) for (k, v) in
  ///                             list(mdict.items()) if v is not None])
  /// ```
  Object? parse({
    required Object? sval,
    Object? granularity = "seconds",
  }) =>
      getFunction("parse").call(
        <Object?>[
          sval,
          granularity,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## timeparse
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  timeparse get $timeparse => timeparse.import();

  /// ## absolute_import (getter)
  ///
  /// ### python docstring
  ///
  /// __init__.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
  ///
  /// `timeparse` module.
  Object? get absolute_import => getAttribute("absolute_import");

  /// ## absolute_import (setter)
  ///
  /// ### python docstring
  ///
  /// __init__.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
  ///
  /// `timeparse` module.
  set absolute_import(Object? absolute_import) =>
      setAttribute("absolute_import", absolute_import);

  /// ## infile (getter)
  ///
  /// ### python docstring
  ///
  /// __init__.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
  ///
  /// `timeparse` module.
  Object? get infile => getAttribute("infile");

  /// ## infile (setter)
  ///
  /// ### python docstring
  ///
  /// __init__.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>   1 February, 2014
  ///
  /// `timeparse` module.
  set infile(Object? infile) => setAttribute("infile", infile);
}

/// ## timeparse
///
/// ### python docstring
///
/// timeparse.py
/// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
///
/// Implements a single function, `timeparse`, which can parse various
/// kinds of time expressions.
///
/// ### python source
/// ```py
/// #!/usr/bin/env python
/// # -*- coding: utf-8 -*-
///
/// '''
/// timeparse.py
/// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
///
/// Implements a single function, `timeparse`, which can parse various
/// kinds of time expressions.
/// '''
///
/// # MIT LICENSE
/// #
/// # Permission is hereby granted, free of charge, to any person
/// # obtaining a copy of this software and associated documentation files
/// # (the "Software"), to deal in the Software without restriction,
/// # including without limitation the rights to use, copy, modify, merge,
/// # publish, distribute, sublicense, and/or sell copies of the Software,
/// # and to permit persons to whom the Software is furnished to do so,
/// # subject to the following conditions:
/// #
/// # The above copyright notice and this permission notice shall be
/// # included in all copies or substantial portions of the Software.
/// #
/// # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
/// # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
/// # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
/// # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
/// # BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
/// # ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
/// # CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// # SOFTWARE.
///
/// import re
///
/// SIGN        = r'(?P<sign>[+|-])?'
/// #YEARS      = r'(?P<years>\d+)\s*(?:ys?|yrs?.?|years?)'
/// #MONTHS     = r'(?P<months>\d+)\s*(?:mos?.?|mths?.?|months?)'
/// WEEKS       = r'(?P<weeks>[\d.]+)\s*(?:w|wks?|weeks?)'
/// DAYS        = r'(?P<days>[\d.]+)\s*(?:d|dys?|days?)'
/// HOURS       = r'(?P<hours>[\d.]+)\s*(?:h|hrs?|hours?)'
/// MINS        = r'(?P<mins>[\d.]+)\s*(?:m|(mins?)|(minutes?))'
/// SECS        = r'(?P<secs>[\d.]+)\s*(?:s|secs?|seconds?)'
/// SEPARATORS  = r'[,/]'
/// SECCLOCK    = r':(?P<secs>\d{2}(?:\.\d+)?)'
/// MINCLOCK    = r'(?P<mins>\d{1,2}):(?P<secs>\d{2}(?:\.\d+)?)'
/// HOURCLOCK   = r'(?P<hours>\d+):(?P<mins>\d{2}):(?P<secs>\d{2}(?:\.\d+)?)'
/// DAYCLOCK    = (r'(?P<days>\d+):(?P<hours>\d{2}):'
///                r'(?P<mins>\d{2}):(?P<secs>\d{2}(?:\.\d+)?)')
///
/// OPT         = lambda x: r'(?:{x})?'.format(x=x, SEPARATORS=SEPARATORS)
/// OPTSEP      = lambda x: r'(?:{x}\s*(?:{SEPARATORS}\s*)?)?'.format(
///     x=x, SEPARATORS=SEPARATORS)
///
/// TIMEFORMATS = [
///     r'{WEEKS}\s*{DAYS}\s*{HOURS}\s*{MINS}\s*{SECS}'.format(
///         #YEARS=OPTSEP(YEARS),
///         #MONTHS=OPTSEP(MONTHS),
///         WEEKS=OPTSEP(WEEKS),
///         DAYS=OPTSEP(DAYS),
///         HOURS=OPTSEP(HOURS),
///         MINS=OPTSEP(MINS),
///         SECS=OPT(SECS)),
///     r'{MINCLOCK}'.format(
///         MINCLOCK=MINCLOCK),
///     r'{WEEKS}\s*{DAYS}\s*{HOURCLOCK}'.format(
///         WEEKS=OPTSEP(WEEKS),
///         DAYS=OPTSEP(DAYS),
///         HOURCLOCK=HOURCLOCK),
///     r'{DAYCLOCK}'.format(
///         DAYCLOCK=DAYCLOCK),
///     r'{SECCLOCK}'.format(
///         SECCLOCK=SECCLOCK),
///     #r'{YEARS}'.format(
///         #YEARS=YEARS),
///     #r'{MONTHS}'.format(
///         #MONTHS=MONTHS),
///     ]
///
/// COMPILED_SIGN = re.compile(r'\s*' + SIGN + r'\s*(?P<unsigned>.*)$')
/// COMPILED_TIMEFORMATS = [re.compile(r'\s*' + timefmt + r'\s*$', re.I)
///                         for timefmt in TIMEFORMATS]
///
/// MULTIPLIERS = dict([
///         #('years',  60 * 60 * 24 * 365),
///         #('months', 60 * 60 * 24 * 30),
///         ('weeks',   60 * 60 * 24 * 7),
///         ('days',    60 * 60 * 24),
///         ('hours',   60 * 60),
///         ('mins',    60),
///         ('secs',    1)
///         ])
///
/// def _interpret_as_minutes(sval, mdict):
///     """
///     Times like "1:22" are ambiguous; do they represent minutes and seconds
///     or hours and minutes?  By default, timeparse assumes the latter.  Call
///     this function after parsing out a dictionary to change that assumption.
///
///     >>> import pprint
///     >>> pprint.pprint(_interpret_as_minutes('1:24', {'secs': '24', 'mins': '1'}))
///     {'hours': '1', 'mins': '24'}
///     """
///     if (    sval.count(':') == 1
///         and '.' not in sval
///         and (('hours' not in mdict) or (mdict['hours'] is None))
///         and (('days' not in mdict) or (mdict['days'] is None))
///         and (('weeks' not in mdict) or (mdict['weeks'] is None))
///         #and (('months' not in mdict) or (mdict['months'] is None))
///         #and (('years' not in mdict) or (mdict['years'] is None))
///         ):
///         mdict['hours'] = mdict['mins']
///         mdict['mins'] = mdict['secs']
///         mdict.pop('secs')
///         pass
///     return mdict
///
/// def timeparse(sval, granularity='seconds'):
///     '''
///     Parse a time expression, returning it as a number of seconds.  If
///     possible, the return value will be an `int`; if this is not
///     possible, the return will be a `float`.  Returns `None` if a time
///     expression cannot be parsed from the given string.
///
///     Arguments:
///     - `sval`: the string value to parse
///
///     >>> timeparse('1:24')
///     84
///     >>> timeparse(':22')
///     22
///     >>> timeparse('1 minute, 24 secs')
///     84
///     >>> timeparse('1m24s')
///     84
///     >>> timeparse('1.2 minutes')
///     72
///     >>> timeparse('1.2 seconds')
///     1.2
///
///     Time expressions can be signed.
///
///     >>> timeparse('- 1 minute')
///     -60
///     >>> timeparse('+ 1 minute')
///     60
///
///     If granularity is specified as ``minutes``, then ambiguous digits following
///     a colon will be interpreted as minutes; otherwise they are considered seconds.
///
///     >>> timeparse('1:30')
///     90
///     >>> timeparse('1:30', granularity='minutes')
///     5400
///     '''
///     match = COMPILED_SIGN.match(sval)
///     sign = -1 if match.groupdict()['sign'] == '-' else 1
///     sval = match.groupdict()['unsigned']
///     for timefmt in COMPILED_TIMEFORMATS:
///         match = timefmt.match(sval)
///         if match and match.group(0).strip():
///             mdict = match.groupdict()
///             if granularity == 'minutes':
///                 mdict = _interpret_as_minutes(sval, mdict)
///             # if all of the fields are integer numbers
///             if all(v.isdigit() for v in list(mdict.values()) if v):
///                 return sign * sum([MULTIPLIERS[k] * int(v, 10) for (k, v) in
///                             list(mdict.items()) if v is not None])
///             # if SECS is an integer number
///             elif ('secs' not in mdict or
///                   mdict['secs'] is None or
///                   mdict['secs'].isdigit()):
///                 # we will return an integer
///                 return (
///                     sign * int(sum([MULTIPLIERS[k] * float(v) for (k, v) in
///                              list(mdict.items()) if k != 'secs' and v is not None])) +
///                     (int(mdict['secs'], 10) if mdict['secs'] else 0))
///             else:
///                 # SECS is a float, we will return a float
///                 return sign * sum([MULTIPLIERS[k] * float(v) for (k, v) in
///                             list(mdict.items()) if v is not None])
/// ```
final class timeparse extends PythonModule {
  timeparse.from(super.pythonModule) : super.from();

  static timeparse import() => PythonFfiDart.instance.importModule(
        "pytimeparse.timeparse",
        timeparse.from,
      );

  /// ## COMPILED_TIMEFORMATS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get COMPILED_TIMEFORMATS => getAttribute("COMPILED_TIMEFORMATS");

  /// ## COMPILED_TIMEFORMATS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set COMPILED_TIMEFORMATS(Object? COMPILED_TIMEFORMATS) =>
      setAttribute("COMPILED_TIMEFORMATS", COMPILED_TIMEFORMATS);

  /// ## DAYCLOCK (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get DAYCLOCK => getAttribute("DAYCLOCK");

  /// ## DAYCLOCK (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set DAYCLOCK(Object? DAYCLOCK) => setAttribute("DAYCLOCK", DAYCLOCK);

  /// ## DAYS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get DAYS => getAttribute("DAYS");

  /// ## DAYS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set DAYS(Object? DAYS) => setAttribute("DAYS", DAYS);

  /// ## HOURCLOCK (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get HOURCLOCK => getAttribute("HOURCLOCK");

  /// ## HOURCLOCK (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set HOURCLOCK(Object? HOURCLOCK) => setAttribute("HOURCLOCK", HOURCLOCK);

  /// ## HOURS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get HOURS => getAttribute("HOURS");

  /// ## HOURS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set HOURS(Object? HOURS) => setAttribute("HOURS", HOURS);

  /// ## MINCLOCK (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get MINCLOCK => getAttribute("MINCLOCK");

  /// ## MINCLOCK (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set MINCLOCK(Object? MINCLOCK) => setAttribute("MINCLOCK", MINCLOCK);

  /// ## MINS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get MINS => getAttribute("MINS");

  /// ## MINS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set MINS(Object? MINS) => setAttribute("MINS", MINS);

  /// ## MULTIPLIERS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get MULTIPLIERS => getAttribute("MULTIPLIERS");

  /// ## MULTIPLIERS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set MULTIPLIERS(Object? MULTIPLIERS) =>
      setAttribute("MULTIPLIERS", MULTIPLIERS);

  /// ## SECCLOCK (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get SECCLOCK => getAttribute("SECCLOCK");

  /// ## SECCLOCK (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set SECCLOCK(Object? SECCLOCK) => setAttribute("SECCLOCK", SECCLOCK);

  /// ## SECS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get SECS => getAttribute("SECS");

  /// ## SECS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set SECS(Object? SECS) => setAttribute("SECS", SECS);

  /// ## SEPARATORS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get SEPARATORS => getAttribute("SEPARATORS");

  /// ## SEPARATORS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set SEPARATORS(Object? SEPARATORS) => setAttribute("SEPARATORS", SEPARATORS);

  /// ## SIGN (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get SIGN => getAttribute("SIGN");

  /// ## SIGN (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set SIGN(Object? SIGN) => setAttribute("SIGN", SIGN);

  /// ## TIMEFORMATS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get TIMEFORMATS => getAttribute("TIMEFORMATS");

  /// ## TIMEFORMATS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set TIMEFORMATS(Object? TIMEFORMATS) =>
      setAttribute("TIMEFORMATS", TIMEFORMATS);

  /// ## WEEKS (getter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  Object? get WEEKS => getAttribute("WEEKS");

  /// ## WEEKS (setter)
  ///
  /// ### python docstring
  ///
  /// timeparse.py
  /// (c) Will Roberts <wildwilhelm@gmail.com>  1 February, 2014
  ///
  /// Implements a single function, `timeparse`, which can parse various
  /// kinds of time expressions.
  set WEEKS(Object? WEEKS) => setAttribute("WEEKS", WEEKS);
}
