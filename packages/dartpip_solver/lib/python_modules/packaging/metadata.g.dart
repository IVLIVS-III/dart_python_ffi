// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library metadata;

import "package:python_ffi_dart/python_ffi_dart.dart";

/// ## RawMetadata
///
/// ### python docstring
///
/// A dictionary of raw core metadata.
///
/// Each field in core metadata maps to a key of this dictionary (when data is
/// provided). The key is lower-case and underscores are used instead of dashes
/// compared to the equivalent core metadata field. Any core metadata field that
/// can be specified multiple times or can hold multiple values in a single
/// field have a key with a plural name.
///
/// Core metadata fields that can be specified multiple times are stored as a
/// list or dict depending on which is appropriate for the field. Any fields
/// which hold multiple values in a single field are stored as a list.
///
/// ### python source
/// ```py
/// class RawMetadata(TypedDict, total=False):
///     """A dictionary of raw core metadata.
///
///     Each field in core metadata maps to a key of this dictionary (when data is
///     provided). The key is lower-case and underscores are used instead of dashes
///     compared to the equivalent core metadata field. Any core metadata field that
///     can be specified multiple times or can hold multiple values in a single
///     field have a key with a plural name.
///
///     Core metadata fields that can be specified multiple times are stored as a
///     list or dict depending on which is appropriate for the field. Any fields
///     which hold multiple values in a single field are stored as a list.
///
///     """
///
///     # Metadata 1.0 - PEP 241
///     metadata_version: str
///     name: str
///     version: str
///     platforms: List[str]
///     summary: str
///     description: str
///     keywords: List[str]
///     home_page: str
///     author: str
///     author_email: str
///     license: str
///
///     # Metadata 1.1 - PEP 314
///     supported_platforms: List[str]
///     download_url: str
///     classifiers: List[str]
///     requires: List[str]
///     provides: List[str]
///     obsoletes: List[str]
///
///     # Metadata 1.2 - PEP 345
///     maintainer: str
///     maintainer_email: str
///     requires_dist: List[str]
///     provides_dist: List[str]
///     obsoletes_dist: List[str]
///     requires_python: str
///     requires_external: List[str]
///     project_urls: Dict[str, str]
///
///     # Metadata 2.0
///     # PEP 426 attempted to completely revamp the metadata format
///     # but got stuck without ever being able to build consensus on
///     # it and ultimately ended up withdrawn.
///     #
///     # However, a number of tools had started emiting METADATA with
///     # `2.0` Metadata-Version, so for historical reasons, this version
///     # was skipped.
///
///     # Metadata 2.1 - PEP 566
///     description_content_type: str
///     provides_extra: List[str]
///
///     # Metadata 2.2 - PEP 643
///     dynamic: List[str]
///
///     # Metadata 2.3 - PEP 685
///     # No new fields were added in PEP 685, just some edge case were
///     # tightened up to provide better interoptability.
/// ```
final class RawMetadata extends PythonClass {
  factory RawMetadata() => PythonFfiDart.instance.importClass(
        "packaging.metadata",
        "RawMetadata",
        RawMetadata.from,
        <Object?>[],
      );

  RawMetadata.from(super.pythonClass) : super.from();

  /// ## clear (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get clear => getAttribute("clear");

  /// ## clear (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set clear(Object? clear) => setAttribute("clear", clear);

  /// ## copy (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get copy => getAttribute("copy");

  /// ## copy (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set copy(Object? copy) => setAttribute("copy", copy);

  /// ## get (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get $get => getAttribute("get");

  /// ## get (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set $get(Object? $get) => setAttribute("get", $get);

  /// ## items (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get items => getAttribute("items");

  /// ## items (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set items(Object? items) => setAttribute("items", items);

  /// ## keys (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get keys => getAttribute("keys");

  /// ## keys (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set keys(Object? keys) => setAttribute("keys", keys);

  /// ## pop (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get pop => getAttribute("pop");

  /// ## pop (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set pop(Object? pop) => setAttribute("pop", pop);

  /// ## popitem (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get popitem => getAttribute("popitem");

  /// ## popitem (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set popitem(Object? popitem) => setAttribute("popitem", popitem);

  /// ## setdefault (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get setdefault => getAttribute("setdefault");

  /// ## setdefault (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set setdefault(Object? setdefault) => setAttribute("setdefault", setdefault);

  /// ## update (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get update => getAttribute("update");

  /// ## update (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set update(Object? update) => setAttribute("update", update);

  /// ## values (getter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  Object? get values => getAttribute("values");

  /// ## values (setter)
  ///
  /// ### python docstring
  ///
  /// A dictionary of raw core metadata.
  ///
  /// Each field in core metadata maps to a key of this dictionary (when data is
  /// provided). The key is lower-case and underscores are used instead of dashes
  /// compared to the equivalent core metadata field. Any core metadata field that
  /// can be specified multiple times or can hold multiple values in a single
  /// field have a key with a plural name.
  ///
  /// Core metadata fields that can be specified multiple times are stored as a
  /// list or dict depending on which is appropriate for the field. Any fields
  /// which hold multiple values in a single field are stored as a list.
  set values(Object? values) => setAttribute("values", values);
}

/// ## metadata
///
/// ### python source
/// ```py
/// import email.feedparser
/// import email.header
/// import email.message
/// import email.parser
/// import email.policy
/// import sys
/// import typing
/// from typing import Dict, List, Optional, Tuple, Union, cast
///
/// if sys.version_info >= (3, 8):  # pragma: no cover
///     from typing import TypedDict
/// else:  # pragma: no cover
///     if typing.TYPE_CHECKING:
///         from typing_extensions import TypedDict
///     else:
///         try:
///             from typing_extensions import TypedDict
///         except ImportError:
///
///             class TypedDict:
///                 def __init_subclass__(*_args, **_kwargs):
///                     pass
///
///
/// # The RawMetadata class attempts to make as few assumptions about the underlying
/// # serialization formats as possible. The idea is that as long as a serialization
/// # formats offer some very basic primitives in *some* way then we can support
/// # serializing to and from that format.
/// class RawMetadata(TypedDict, total=False):
///     """A dictionary of raw core metadata.
///
///     Each field in core metadata maps to a key of this dictionary (when data is
///     provided). The key is lower-case and underscores are used instead of dashes
///     compared to the equivalent core metadata field. Any core metadata field that
///     can be specified multiple times or can hold multiple values in a single
///     field have a key with a plural name.
///
///     Core metadata fields that can be specified multiple times are stored as a
///     list or dict depending on which is appropriate for the field. Any fields
///     which hold multiple values in a single field are stored as a list.
///
///     """
///
///     # Metadata 1.0 - PEP 241
///     metadata_version: str
///     name: str
///     version: str
///     platforms: List[str]
///     summary: str
///     description: str
///     keywords: List[str]
///     home_page: str
///     author: str
///     author_email: str
///     license: str
///
///     # Metadata 1.1 - PEP 314
///     supported_platforms: List[str]
///     download_url: str
///     classifiers: List[str]
///     requires: List[str]
///     provides: List[str]
///     obsoletes: List[str]
///
///     # Metadata 1.2 - PEP 345
///     maintainer: str
///     maintainer_email: str
///     requires_dist: List[str]
///     provides_dist: List[str]
///     obsoletes_dist: List[str]
///     requires_python: str
///     requires_external: List[str]
///     project_urls: Dict[str, str]
///
///     # Metadata 2.0
///     # PEP 426 attempted to completely revamp the metadata format
///     # but got stuck without ever being able to build consensus on
///     # it and ultimately ended up withdrawn.
///     #
///     # However, a number of tools had started emiting METADATA with
///     # `2.0` Metadata-Version, so for historical reasons, this version
///     # was skipped.
///
///     # Metadata 2.1 - PEP 566
///     description_content_type: str
///     provides_extra: List[str]
///
///     # Metadata 2.2 - PEP 643
///     dynamic: List[str]
///
///     # Metadata 2.3 - PEP 685
///     # No new fields were added in PEP 685, just some edge case were
///     # tightened up to provide better interoptability.
///
///
/// _STRING_FIELDS = {
///     "author",
///     "author_email",
///     "description",
///     "description_content_type",
///     "download_url",
///     "home_page",
///     "license",
///     "maintainer",
///     "maintainer_email",
///     "metadata_version",
///     "name",
///     "requires_python",
///     "summary",
///     "version",
/// }
///
/// _LIST_STRING_FIELDS = {
///     "classifiers",
///     "dynamic",
///     "obsoletes",
///     "obsoletes_dist",
///     "platforms",
///     "provides",
///     "provides_dist",
///     "provides_extra",
///     "requires",
///     "requires_dist",
///     "requires_external",
///     "supported_platforms",
/// }
///
///
/// def _parse_keywords(data: str) -> List[str]:
///     """Split a string of comma-separate keyboards into a list of keywords."""
///     return [k.strip() for k in data.split(",")]
///
///
/// def _parse_project_urls(data: List[str]) -> Dict[str, str]:
///     """Parse a list of label/URL string pairings separated by a comma."""
///     urls = {}
///     for pair in data:
///         # Our logic is slightly tricky here as we want to try and do
///         # *something* reasonable with malformed data.
///         #
///         # The main thing that we have to worry about, is data that does
///         # not have a ',' at all to split the label from the Value. There
///         # isn't a singular right answer here, and we will fail validation
///         # later on (if the caller is validating) so it doesn't *really*
///         # matter, but since the missing value has to be an empty str
///         # and our return value is dict[str, str], if we let the key
///         # be the missing value, then they'd have multiple '' values that
///         # overwrite each other in a accumulating dict.
///         #
///         # The other potentional issue is that it's possible to have the
///         # same label multiple times in the metadata, with no solid "right"
///         # answer with what to do in that case. As such, we'll do the only
///         # thing we can, which is treat the field as unparseable and add it
///         # to our list of unparsed fields.
///         parts = [p.strip() for p in pair.split(",", 1)]
///         parts.extend([""] * (max(0, 2 - len(parts))))  # Ensure 2 items
///
///         # TODO: The spec doesn't say anything about if the keys should be
///         #       considered case sensitive or not... logically they should
///         #       be case-preserving and case-insensitive, but doing that
///         #       would open up more cases where we might have duplicate
///         #       entries.
///         label, url = parts
///         if label in urls:
///             # The label already exists in our set of urls, so this field
///             # is unparseable, and we can just add the whole thing to our
///             # unparseable data and stop processing it.
///             raise KeyError("duplicate labels in project urls")
///         urls[label] = url
///
///     return urls
///
///
/// def _get_payload(msg: email.message.Message, source: Union[bytes, str]) -> str:
///     """Get the body of the message."""
///     # If our source is a str, then our caller has managed encodings for us,
///     # and we don't need to deal with it.
///     if isinstance(source, str):
///         payload: str = msg.get_payload()
///         return payload
///     # If our source is a bytes, then we're managing the encoding and we need
///     # to deal with it.
///     else:
///         bpayload: bytes = msg.get_payload(decode=True)
///         try:
///             return bpayload.decode("utf8", "strict")
///         except UnicodeDecodeError:
///             raise ValueError("payload in an invalid encoding")
///
///
/// # The various parse_FORMAT functions here are intended to be as lenient as
/// # possible in their parsing, while still returning a correctly typed
/// # RawMetadata.
/// #
/// # To aid in this, we also generally want to do as little touching of the
/// # data as possible, except where there are possibly some historic holdovers
/// # that make valid data awkward to work with.
/// #
/// # While this is a lower level, intermediate format than our ``Metadata``
/// # class, some light touch ups can make a massive difference in usability.
///
/// # Map METADATA fields to RawMetadata.
/// _EMAIL_TO_RAW_MAPPING = {
///     "author": "author",
///     "author-email": "author_email",
///     "classifier": "classifiers",
///     "description": "description",
///     "description-content-type": "description_content_type",
///     "download-url": "download_url",
///     "dynamic": "dynamic",
///     "home-page": "home_page",
///     "keywords": "keywords",
///     "license": "license",
///     "maintainer": "maintainer",
///     "maintainer-email": "maintainer_email",
///     "metadata-version": "metadata_version",
///     "name": "name",
///     "obsoletes": "obsoletes",
///     "obsoletes-dist": "obsoletes_dist",
///     "platform": "platforms",
///     "project-url": "project_urls",
///     "provides": "provides",
///     "provides-dist": "provides_dist",
///     "provides-extra": "provides_extra",
///     "requires": "requires",
///     "requires-dist": "requires_dist",
///     "requires-external": "requires_external",
///     "requires-python": "requires_python",
///     "summary": "summary",
///     "supported-platform": "supported_platforms",
///     "version": "version",
/// }
///
///
/// def parse_email(data: Union[bytes, str]) -> Tuple[RawMetadata, Dict[str, List[str]]]:
///     """Parse a distribution's metadata.
///
///     This function returns a two-item tuple of dicts. The first dict is of
///     recognized fields from the core metadata specification. Fields that can be
///     parsed and translated into Python's built-in types are converted
///     appropriately. All other fields are left as-is. Fields that are allowed to
///     appear multiple times are stored as lists.
///
///     The second dict contains all other fields from the metadata. This includes
///     any unrecognized fields. It also includes any fields which are expected to
///     be parsed into a built-in type but were not formatted appropriately. Finally,
///     any fields that are expected to appear only once but are repeated are
///     included in this dict.
///
///     """
///     raw: Dict[str, Union[str, List[str], Dict[str, str]]] = {}
///     unparsed: Dict[str, List[str]] = {}
///
///     if isinstance(data, str):
///         parsed = email.parser.Parser(policy=email.policy.compat32).parsestr(data)
///     else:
///         parsed = email.parser.BytesParser(policy=email.policy.compat32).parsebytes(data)
///
///     # We have to wrap parsed.keys() in a set, because in the case of multiple
///     # values for a key (a list), the key will appear multiple times in the
///     # list of keys, but we're avoiding that by using get_all().
///     for name in frozenset(parsed.keys()):
///         # Header names in RFC are case insensitive, so we'll normalize to all
///         # lower case to make comparisons easier.
///         name = name.lower()
///
///         # We use get_all() here, even for fields that aren't multiple use,
///         # because otherwise someone could have e.g. two Name fields, and we
///         # would just silently ignore it rather than doing something about it.
///         headers = parsed.get_all(name)
///
///         # The way the email module works when parsing bytes is that it
///         # unconditionally decodes the bytes as ascii using the surrogateescape
///         # handler. When you pull that data back out (such as with get_all() ),
///         # it looks to see if the str has any surrogate escapes, and if it does
///         # it wraps it in a Header object instead of returning the string.
///         #
///         # As such, we'll look for those Header objects, and fix up the encoding.
///         value = []
///         # Flag if we have run into any issues processing the headers, thus
///         # signalling that the data belongs in 'unparsed'.
///         valid_encoding = True
///         for h in headers:
///             # It's unclear if this can return more types than just a Header or
///             # a str, so we'll just assert here to make sure.
///             assert isinstance(h, (email.header.Header, str))
///
///             # If it's a header object, we need to do our little dance to get
///             # the real data out of it. In cases where there is invalid data
///             # we're going to end up with mojibake, but there's no obvious, good
///             # way around that without reimplementing parts of the Header object
///             # ourselves.
///             #
///             # That should be fine since, if mojibacked happens, this key is
///             # going into the unparsed dict anyways.
///             if isinstance(h, email.header.Header):
///                 # The Header object stores it's data as chunks, and each chunk
///                 # can be independently encoded, so we'll need to check each
///                 # of them.
///                 chunks: List[Tuple[bytes, Optional[str]]] = []
///                 for bin, encoding in email.header.decode_header(h):
///                     try:
///                         bin.decode("utf8", "strict")
///                     except UnicodeDecodeError:
///                         # Enable mojibake.
///                         encoding = "latin1"
///                         valid_encoding = False
///                     else:
///                         encoding = "utf8"
///                     chunks.append((bin, encoding))
///
///                 # Turn our chunks back into a Header object, then let that
///                 # Header object do the right thing to turn them into a
///                 # string for us.
///                 value.append(str(email.header.make_header(chunks)))
///             # This is already a string, so just add it.
///             else:
///                 value.append(h)
///
///         # We've processed all of our values to get them into a list of str,
///         # but we may have mojibake data, in which case this is an unparsed
///         # field.
///         if not valid_encoding:
///             unparsed[name] = value
///             continue
///
///         raw_name = _EMAIL_TO_RAW_MAPPING.get(name)
///         if raw_name is None:
///             # This is a bit of a weird situation, we've encountered a key that
///             # we don't know what it means, so we don't know whether it's meant
///             # to be a list or not.
///             #
///             # Since we can't really tell one way or another, we'll just leave it
///             # as a list, even though it may be a single item list, because that's
///             # what makes the most sense for email headers.
///             unparsed[name] = value
///             continue
///
///         # If this is one of our string fields, then we'll check to see if our
///         # value is a list of a single item. If it is then we'll assume that
///         # it was emitted as a single string, and unwrap the str from inside
///         # the list.
///         #
///         # If it's any other kind of data, then we haven't the faintest clue
///         # what we should parse it as, and we have to just add it to our list
///         # of unparsed stuff.
///         if raw_name in _STRING_FIELDS and len(value) == 1:
///             raw[raw_name] = value[0]
///         # If this is one of our list of string fields, then we can just assign
///         # the value, since email *only* has strings, and our get_all() call
///         # above ensures that this is a list.
///         elif raw_name in _LIST_STRING_FIELDS:
///             raw[raw_name] = value
///         # Special Case: Keywords
///         # The keywords field is implemented in the metadata spec as a str,
///         # but it conceptually is a list of strings, and is serialized using
///         # ", ".join(keywords), so we'll do some light data massaging to turn
///         # this into what it logically is.
///         elif raw_name == "keywords" and len(value) == 1:
///             raw[raw_name] = _parse_keywords(value[0])
///         # Special Case: Project-URL
///         # The project urls is implemented in the metadata spec as a list of
///         # specially-formatted strings that represent a key and a value, which
///         # is fundamentally a mapping, however the email format doesn't support
///         # mappings in a sane way, so it was crammed into a list of strings
///         # instead.
///         #
///         # We will do a little light data massaging to turn this into a map as
///         # it logically should be.
///         elif raw_name == "project_urls":
///             try:
///                 raw[raw_name] = _parse_project_urls(value)
///             except KeyError:
///                 unparsed[name] = value
///         # Nothing that we've done has managed to parse this, so it'll just
///         # throw it in our unparseable data and move on.
///         else:
///             unparsed[name] = value
///
///     # We need to support getting the Description from the message payload in
///     # addition to getting it from the the headers. This does mean, though, there
///     # is the possibility of it being set both ways, in which case we put both
///     # in 'unparsed' since we don't know which is right.
///     try:
///         payload = _get_payload(parsed, data)
///     except ValueError:
///         unparsed.setdefault("description", []).append(
///             parsed.get_payload(decode=isinstance(data, bytes))
///         )
///     else:
///         if payload:
///             # Check to see if we've already got a description, if so then both
///             # it, and this body move to unparseable.
///             if "description" in raw:
///                 description_header = cast(str, raw.pop("description"))
///                 unparsed.setdefault("description", []).extend(
///                     [description_header, payload]
///                 )
///             elif "description" in unparsed:
///                 unparsed["description"].append(payload)
///             else:
///                 raw["description"] = payload
///
///     # We need to cast our `raw` to a metadata, because a TypedDict only support
///     # literal key names, but we're computing our key names on purpose, but the
///     # way this function is implemented, our `TypedDict` can only have valid key
///     # names.
///     return cast(RawMetadata, raw), unparsed
/// ```
final class metadata extends PythonModule {
  metadata.from(super.pythonModule) : super.from();

  static metadata import() => PythonFfiDart.instance.importModule(
        "packaging.metadata",
        metadata.from,
      );

  /// ## parse_email
  ///
  /// ### python docstring
  ///
  /// Parse a distribution's metadata.
  ///
  /// This function returns a two-item tuple of dicts. The first dict is of
  /// recognized fields from the core metadata specification. Fields that can be
  /// parsed and translated into Python's built-in types are converted
  /// appropriately. All other fields are left as-is. Fields that are allowed to
  /// appear multiple times are stored as lists.
  ///
  /// The second dict contains all other fields from the metadata. This includes
  /// any unrecognized fields. It also includes any fields which are expected to
  /// be parsed into a built-in type but were not formatted appropriately. Finally,
  /// any fields that are expected to appear only once but are repeated are
  /// included in this dict.
  ///
  /// ### python source
  /// ```py
  /// def parse_email(data: Union[bytes, str]) -> Tuple[RawMetadata, Dict[str, List[str]]]:
  ///     """Parse a distribution's metadata.
  ///
  ///     This function returns a two-item tuple of dicts. The first dict is of
  ///     recognized fields from the core metadata specification. Fields that can be
  ///     parsed and translated into Python's built-in types are converted
  ///     appropriately. All other fields are left as-is. Fields that are allowed to
  ///     appear multiple times are stored as lists.
  ///
  ///     The second dict contains all other fields from the metadata. This includes
  ///     any unrecognized fields. It also includes any fields which are expected to
  ///     be parsed into a built-in type but were not formatted appropriately. Finally,
  ///     any fields that are expected to appear only once but are repeated are
  ///     included in this dict.
  ///
  ///     """
  ///     raw: Dict[str, Union[str, List[str], Dict[str, str]]] = {}
  ///     unparsed: Dict[str, List[str]] = {}
  ///
  ///     if isinstance(data, str):
  ///         parsed = email.parser.Parser(policy=email.policy.compat32).parsestr(data)
  ///     else:
  ///         parsed = email.parser.BytesParser(policy=email.policy.compat32).parsebytes(data)
  ///
  ///     # We have to wrap parsed.keys() in a set, because in the case of multiple
  ///     # values for a key (a list), the key will appear multiple times in the
  ///     # list of keys, but we're avoiding that by using get_all().
  ///     for name in frozenset(parsed.keys()):
  ///         # Header names in RFC are case insensitive, so we'll normalize to all
  ///         # lower case to make comparisons easier.
  ///         name = name.lower()
  ///
  ///         # We use get_all() here, even for fields that aren't multiple use,
  ///         # because otherwise someone could have e.g. two Name fields, and we
  ///         # would just silently ignore it rather than doing something about it.
  ///         headers = parsed.get_all(name)
  ///
  ///         # The way the email module works when parsing bytes is that it
  ///         # unconditionally decodes the bytes as ascii using the surrogateescape
  ///         # handler. When you pull that data back out (such as with get_all() ),
  ///         # it looks to see if the str has any surrogate escapes, and if it does
  ///         # it wraps it in a Header object instead of returning the string.
  ///         #
  ///         # As such, we'll look for those Header objects, and fix up the encoding.
  ///         value = []
  ///         # Flag if we have run into any issues processing the headers, thus
  ///         # signalling that the data belongs in 'unparsed'.
  ///         valid_encoding = True
  ///         for h in headers:
  ///             # It's unclear if this can return more types than just a Header or
  ///             # a str, so we'll just assert here to make sure.
  ///             assert isinstance(h, (email.header.Header, str))
  ///
  ///             # If it's a header object, we need to do our little dance to get
  ///             # the real data out of it. In cases where there is invalid data
  ///             # we're going to end up with mojibake, but there's no obvious, good
  ///             # way around that without reimplementing parts of the Header object
  ///             # ourselves.
  ///             #
  ///             # That should be fine since, if mojibacked happens, this key is
  ///             # going into the unparsed dict anyways.
  ///             if isinstance(h, email.header.Header):
  ///                 # The Header object stores it's data as chunks, and each chunk
  ///                 # can be independently encoded, so we'll need to check each
  ///                 # of them.
  ///                 chunks: List[Tuple[bytes, Optional[str]]] = []
  ///                 for bin, encoding in email.header.decode_header(h):
  ///                     try:
  ///                         bin.decode("utf8", "strict")
  ///                     except UnicodeDecodeError:
  ///                         # Enable mojibake.
  ///                         encoding = "latin1"
  ///                         valid_encoding = False
  ///                     else:
  ///                         encoding = "utf8"
  ///                     chunks.append((bin, encoding))
  ///
  ///                 # Turn our chunks back into a Header object, then let that
  ///                 # Header object do the right thing to turn them into a
  ///                 # string for us.
  ///                 value.append(str(email.header.make_header(chunks)))
  ///             # This is already a string, so just add it.
  ///             else:
  ///                 value.append(h)
  ///
  ///         # We've processed all of our values to get them into a list of str,
  ///         # but we may have mojibake data, in which case this is an unparsed
  ///         # field.
  ///         if not valid_encoding:
  ///             unparsed[name] = value
  ///             continue
  ///
  ///         raw_name = _EMAIL_TO_RAW_MAPPING.get(name)
  ///         if raw_name is None:
  ///             # This is a bit of a weird situation, we've encountered a key that
  ///             # we don't know what it means, so we don't know whether it's meant
  ///             # to be a list or not.
  ///             #
  ///             # Since we can't really tell one way or another, we'll just leave it
  ///             # as a list, even though it may be a single item list, because that's
  ///             # what makes the most sense for email headers.
  ///             unparsed[name] = value
  ///             continue
  ///
  ///         # If this is one of our string fields, then we'll check to see if our
  ///         # value is a list of a single item. If it is then we'll assume that
  ///         # it was emitted as a single string, and unwrap the str from inside
  ///         # the list.
  ///         #
  ///         # If it's any other kind of data, then we haven't the faintest clue
  ///         # what we should parse it as, and we have to just add it to our list
  ///         # of unparsed stuff.
  ///         if raw_name in _STRING_FIELDS and len(value) == 1:
  ///             raw[raw_name] = value[0]
  ///         # If this is one of our list of string fields, then we can just assign
  ///         # the value, since email *only* has strings, and our get_all() call
  ///         # above ensures that this is a list.
  ///         elif raw_name in _LIST_STRING_FIELDS:
  ///             raw[raw_name] = value
  ///         # Special Case: Keywords
  ///         # The keywords field is implemented in the metadata spec as a str,
  ///         # but it conceptually is a list of strings, and is serialized using
  ///         # ", ".join(keywords), so we'll do some light data massaging to turn
  ///         # this into what it logically is.
  ///         elif raw_name == "keywords" and len(value) == 1:
  ///             raw[raw_name] = _parse_keywords(value[0])
  ///         # Special Case: Project-URL
  ///         # The project urls is implemented in the metadata spec as a list of
  ///         # specially-formatted strings that represent a key and a value, which
  ///         # is fundamentally a mapping, however the email format doesn't support
  ///         # mappings in a sane way, so it was crammed into a list of strings
  ///         # instead.
  ///         #
  ///         # We will do a little light data massaging to turn this into a map as
  ///         # it logically should be.
  ///         elif raw_name == "project_urls":
  ///             try:
  ///                 raw[raw_name] = _parse_project_urls(value)
  ///             except KeyError:
  ///                 unparsed[name] = value
  ///         # Nothing that we've done has managed to parse this, so it'll just
  ///         # throw it in our unparseable data and move on.
  ///         else:
  ///             unparsed[name] = value
  ///
  ///     # We need to support getting the Description from the message payload in
  ///     # addition to getting it from the the headers. This does mean, though, there
  ///     # is the possibility of it being set both ways, in which case we put both
  ///     # in 'unparsed' since we don't know which is right.
  ///     try:
  ///         payload = _get_payload(parsed, data)
  ///     except ValueError:
  ///         unparsed.setdefault("description", []).append(
  ///             parsed.get_payload(decode=isinstance(data, bytes))
  ///         )
  ///     else:
  ///         if payload:
  ///             # Check to see if we've already got a description, if so then both
  ///             # it, and this body move to unparseable.
  ///             if "description" in raw:
  ///                 description_header = cast(str, raw.pop("description"))
  ///                 unparsed.setdefault("description", []).extend(
  ///                     [description_header, payload]
  ///                 )
  ///             elif "description" in unparsed:
  ///                 unparsed["description"].append(payload)
  ///             else:
  ///                 raw["description"] = payload
  ///
  ///     # We need to cast our `raw` to a metadata, because a TypedDict only support
  ///     # literal key names, but we're computing our key names on purpose, but the
  ///     # way this function is implemented, our `TypedDict` can only have valid key
  ///     # names.
  ///     return cast(RawMetadata, raw), unparsed
  /// ```
  Object? parse_email({
    required Object? data,
  }) =>
      getFunction("parse_email").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## sys
  sys get $sys => sys.import();

  /// ## Dict (getter)
  Object? get Dict => getAttribute("Dict");

  /// ## Dict (setter)
  set Dict(Object? Dict) => setAttribute("Dict", Dict);

  /// ## List (getter)
  Object? get $List => getAttribute("List");

  /// ## List (setter)
  set $List(Object? $List) => setAttribute("List", $List);

  /// ## Optional (getter)
  Object? get Optional => getAttribute("Optional");

  /// ## Optional (setter)
  set Optional(Object? Optional) => setAttribute("Optional", Optional);

  /// ## Tuple (getter)
  Object? get Tuple => getAttribute("Tuple");

  /// ## Tuple (setter)
  set Tuple(Object? Tuple) => setAttribute("Tuple", Tuple);

  /// ## Union (getter)
  Object? get Union => getAttribute("Union");

  /// ## Union (setter)
  set Union(Object? Union) => setAttribute("Union", Union);
}

/// ## sys
final class sys extends PythonModule {
  sys.from(super.pythonModule) : super.from();

  static sys import() => PythonFfiDart.instance.importModule(
        "packaging.sys",
        sys.from,
      );

  /// ## abiflags (getter)
  Object? get abiflags => getAttribute("abiflags");

  /// ## abiflags (setter)
  set abiflags(Object? abiflags) => setAttribute("abiflags", abiflags);

  /// ## api_version (getter)
  Object? get api_version => getAttribute("api_version");

  /// ## api_version (setter)
  set api_version(Object? api_version) =>
      setAttribute("api_version", api_version);

  /// ## argv (getter)
  Object? get argv => getAttribute("argv");

  /// ## argv (setter)
  set argv(Object? argv) => setAttribute("argv", argv);

  /// ## base_exec_prefix (getter)
  Object? get base_exec_prefix => getAttribute("base_exec_prefix");

  /// ## base_exec_prefix (setter)
  set base_exec_prefix(Object? base_exec_prefix) =>
      setAttribute("base_exec_prefix", base_exec_prefix);

  /// ## base_prefix (getter)
  Object? get base_prefix => getAttribute("base_prefix");

  /// ## base_prefix (setter)
  set base_prefix(Object? base_prefix) =>
      setAttribute("base_prefix", base_prefix);

  /// ## builtin_module_names (getter)
  Object? get builtin_module_names => getAttribute("builtin_module_names");

  /// ## builtin_module_names (setter)
  set builtin_module_names(Object? builtin_module_names) =>
      setAttribute("builtin_module_names", builtin_module_names);

  /// ## byteorder (getter)
  Object? get byteorder => getAttribute("byteorder");

  /// ## byteorder (setter)
  set byteorder(Object? byteorder) => setAttribute("byteorder", byteorder);

  /// ## copyright (getter)
  Object? get copyright => getAttribute("copyright");

  /// ## copyright (setter)
  set copyright(Object? copyright) => setAttribute("copyright", copyright);

  /// ## dont_write_bytecode (getter)
  Object? get dont_write_bytecode => getAttribute("dont_write_bytecode");

  /// ## dont_write_bytecode (setter)
  set dont_write_bytecode(Object? dont_write_bytecode) =>
      setAttribute("dont_write_bytecode", dont_write_bytecode);

  /// ## exec_prefix (getter)
  Object? get exec_prefix => getAttribute("exec_prefix");

  /// ## exec_prefix (setter)
  set exec_prefix(Object? exec_prefix) =>
      setAttribute("exec_prefix", exec_prefix);

  /// ## executable (getter)
  Object? get executable => getAttribute("executable");

  /// ## executable (setter)
  set executable(Object? executable) => setAttribute("executable", executable);

  /// ## flags (getter)
  Object? get flags => getAttribute("flags");

  /// ## flags (setter)
  set flags(Object? flags) => setAttribute("flags", flags);

  /// ## float_info (getter)
  Object? get float_info => getAttribute("float_info");

  /// ## float_info (setter)
  set float_info(Object? float_info) => setAttribute("float_info", float_info);

  /// ## float_repr_style (getter)
  Object? get float_repr_style => getAttribute("float_repr_style");

  /// ## float_repr_style (setter)
  set float_repr_style(Object? float_repr_style) =>
      setAttribute("float_repr_style", float_repr_style);

  /// ## hash_info (getter)
  Object? get hash_info => getAttribute("hash_info");

  /// ## hash_info (setter)
  set hash_info(Object? hash_info) => setAttribute("hash_info", hash_info);

  /// ## hexversion (getter)
  Object? get hexversion => getAttribute("hexversion");

  /// ## hexversion (setter)
  set hexversion(Object? hexversion) => setAttribute("hexversion", hexversion);

  /// ## int_info (getter)
  Object? get int_info => getAttribute("int_info");

  /// ## int_info (setter)
  set int_info(Object? int_info) => setAttribute("int_info", int_info);

  /// ## maxsize (getter)
  Object? get maxsize => getAttribute("maxsize");

  /// ## maxsize (setter)
  set maxsize(Object? maxsize) => setAttribute("maxsize", maxsize);

  /// ## maxunicode (getter)
  Object? get maxunicode => getAttribute("maxunicode");

  /// ## maxunicode (setter)
  set maxunicode(Object? maxunicode) => setAttribute("maxunicode", maxunicode);

  /// ## meta_path (getter)
  Object? get meta_path => getAttribute("meta_path");

  /// ## meta_path (setter)
  set meta_path(Object? meta_path) => setAttribute("meta_path", meta_path);

  /// ## modules (getter)
  Object? get modules => getAttribute("modules");

  /// ## modules (setter)
  set modules(Object? modules) => setAttribute("modules", modules);

  /// ## orig_argv (getter)
  Object? get orig_argv => getAttribute("orig_argv");

  /// ## orig_argv (setter)
  set orig_argv(Object? orig_argv) => setAttribute("orig_argv", orig_argv);

  /// ## path (getter)
  Object? get path => getAttribute("path");

  /// ## path (setter)
  set path(Object? path) => setAttribute("path", path);

  /// ## path_hooks (getter)
  Object? get path_hooks => getAttribute("path_hooks");

  /// ## path_hooks (setter)
  set path_hooks(Object? path_hooks) => setAttribute("path_hooks", path_hooks);

  /// ## path_importer_cache (getter)
  Object? get path_importer_cache => getAttribute("path_importer_cache");

  /// ## path_importer_cache (setter)
  set path_importer_cache(Object? path_importer_cache) =>
      setAttribute("path_importer_cache", path_importer_cache);

  /// ## platform (getter)
  Object? get $platform => getAttribute("platform");

  /// ## platform (setter)
  set $platform(Object? $platform) => setAttribute("platform", $platform);

  /// ## platlibdir (getter)
  Object? get platlibdir => getAttribute("platlibdir");

  /// ## platlibdir (setter)
  set platlibdir(Object? platlibdir) => setAttribute("platlibdir", platlibdir);

  /// ## prefix (getter)
  Object? get prefix => getAttribute("prefix");

  /// ## prefix (setter)
  set prefix(Object? prefix) => setAttribute("prefix", prefix);

  /// ## pycache_prefix (getter)
  Null get pycache_prefix => getAttribute("pycache_prefix");

  /// ## pycache_prefix (setter)
  set pycache_prefix(Null pycache_prefix) =>
      setAttribute("pycache_prefix", pycache_prefix);

  /// ## thread_info (getter)
  Object? get thread_info => getAttribute("thread_info");

  /// ## thread_info (setter)
  set thread_info(Object? thread_info) =>
      setAttribute("thread_info", thread_info);

  /// ## version (getter)
  Object? get version => getAttribute("version");

  /// ## version (setter)
  set version(Object? version) => setAttribute("version", version);

  /// ## version_info (getter)
  Object? get version_info => getAttribute("version_info");

  /// ## version_info (setter)
  set version_info(Object? version_info) =>
      setAttribute("version_info", version_info);

  /// ## warnoptions (getter)
  Object? get warnoptions => getAttribute("warnoptions");

  /// ## warnoptions (setter)
  set warnoptions(Object? warnoptions) =>
      setAttribute("warnoptions", warnoptions);
}
