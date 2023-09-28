// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_void_to_null

library liblax;

import "package:python_ffi/python_ffi.dart";

/// ## Block
///
/// ### python source
/// ```py
/// class Block:
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, exp0, exp1):
///         self.exp0 = exp0
///         self.exp1  = exp1
///
///     def __str__(self, op=None):
///         tmp = '\\left(%s\\right)'
///         lhs = self.exp0.__str__(self)
///         lhs = tmp % lhs if not isinstance(self.exp0, Block) else lhs
///         rhs = self.exp1.__str__(self)
///         rhs = tmp % rhs if not isinstance(self.exp1, Block) else rhs
///         return '%s%s' % (lhs, rhs)
/// ```
final class Block extends PythonClass {
  factory Block({
    required Object? exp0,
    required Object? exp1,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Block",
        Block.from,
        <Object?>[
          exp0,
          exp1,
        ],
        <String, Object?>{},
      );

  Block.from(super.pythonClass) : super.from();

  /// ## exp0 (getter)
  Object? get exp0 => getAttribute("exp0");

  /// ## exp0 (setter)
  set exp0(Object? exp0) => setAttribute("exp0", exp0);

  /// ## exp1 (getter)
  Object? get exp1 => getAttribute("exp1");

  /// ## exp1 (setter)
  set exp1(Object? exp1) => setAttribute("exp1", exp1);
}

/// ## Chk
///
/// ### python source
/// ```py
/// class Chk:
///     def __call__(self, exp):
///         return Function(self, exp)
///
///     def __init__(self, val):
///         self.val = val
///
///     def __add__(self, other):
///         return Sum(self, other)
///
///     def __radd__(self, other):
///         return Sum(other, self)
///
///     def __sub__(self, other):
///         return Sub(self, other)
///
///     def __rsub__(self, other):
///         return Sub(other, self)
///
///     def __str__(self, op=None):
///         return self.val
///
///     def __mul__(self, other):
///         return Mul(self, other)
///
///     def __rmul__(self, other):
///         return Mul(other, self)
///
///     def __truediv__(self, other):
///         return Div(self, other)
///
///     def __rtruediv__(self, other):
///         return Div(other, self)
///
///     def __pow__(self, other):
///         return Exp(other, self)
///
///     def __rpow__(self, other):
///         return Exp(self, other)
///
///     def __rxor__(self, other):
///         return Pow(self, other)
///
///     def __xor__(self, other):
///         return Pow(other, self)
/// ```
final class Chk extends PythonClass {
  factory Chk({
    required Object? val,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Chk",
        Chk.from,
        <Object?>[
          val,
        ],
        <String, Object?>{},
      );

  Chk.from(super.pythonClass) : super.from();

  /// ## val (getter)
  Object? get val => getAttribute("val");

  /// ## val (setter)
  set val(Object? val) => setAttribute("val", val);
}

/// ## Div
///
/// ### python source
/// ```py
/// class Div(Op):
///     def __init__(self, lhs, rhs):
///         DIV_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT1,
///                 Exp: FMT1,
///
///               }
///
///         DIV_OP_MAP = {
///
///         }
///
///
///         DEFAULT_DIV_OP_MAP = lambda rhs, lhs: '\\frac{%s}{%s}' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, DIV_ARG_MAP, DIV_OP_MAP, FMT0,
///                     DEFAULT_DIV_OP_MAP)
/// ```
final class Div extends PythonClass {
  factory Div({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Div",
        Div.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Div.from(super.pythonClass) : super.from();
}

/// ## Exp
///
/// ### python source
/// ```py
/// class Exp(Op):
///     def __init__(self, lhs, rhs):
///         DEFAULT_EXP_OP_MAP = lambda lhs, rhs: '{%s}^{%s}' % (rhs, lhs)
///
///         EXP_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT0,
///                 Exp: FMT1,
///
///               }
///
///         EXP_OP_MAP = {
///
///         }
///
///         Op.__init__(self, lhs, rhs, EXP_ARG_MAP, EXP_OP_MAP, FMT0,
///                     DEFAULT_EXP_OP_MAP)
/// ```
final class Exp extends PythonClass {
  factory Exp({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Exp",
        Exp.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Exp.from(super.pythonClass) : super.from();
}

/// ## Function
///
/// ### python source
/// ```py
/// class Function:
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, name, exp):
///         self.name = name
///         self.exp  = exp
///
///     def __str__(self, op=None):
///         return '%s\\left(%s\\right)' % (self.name, self.exp.__str__(self))
/// ```
final class $Function extends PythonClass {
  factory $Function({
    required Object? name,
    required Object? exp,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Function",
        $Function.from,
        <Object?>[
          name,
          exp,
        ],
        <String, Object?>{},
      );

  $Function.from(super.pythonClass) : super.from();

  /// ## name (getter)
  Object? get name => getAttribute("name");

  /// ## name (setter)
  set name(Object? name) => setAttribute("name", name);

  /// ## exp (getter)
  Object? get exp => getAttribute("exp");

  /// ## exp (setter)
  set exp(Object? exp) => setAttribute("exp", exp);
}

/// ## Mul
///
/// ### python source
/// ```py
/// class Mul(Op):
///     def __init__(self, lhs, rhs):
///
///         MUL_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT1,
///                 Exp: FMT1,
///               }
///
///         MUL_OP_MAP = {
///
///         }
///
///         DEFAULT_MUL_OP_MAP = lambda rhs, lhs: '%s\cdot %s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, MUL_ARG_MAP, MUL_OP_MAP, FMT0,
///                     DEFAULT_MUL_OP_MAP)
/// ```
final class Mul extends PythonClass {
  factory Mul({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Mul",
        Mul.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Mul.from(super.pythonClass) : super.from();
}

/// ## Num
///
/// ### python source
/// ```py
/// class Num(Chk):
///     def __init__(self, val):
///         Chk.__init__(self, val)
/// ```
final class Num extends PythonClass {
  factory Num({
    required Object? val,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Num",
        Num.from,
        <Object?>[
          val,
        ],
        <String, Object?>{},
      );

  Num.from(super.pythonClass) : super.from();
}

/// ## Op
///
/// ### python source
/// ```py
/// class Op(Chk):
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, lhs, rhs, arg_map, op_map, default_arg_map, default_op_map):
///         self.lhs              = lhs
///         self.rhs              = rhs
///         self.arg_map          = arg_map
///         self.op_map           = op_map
///         self.default_arg_map  = default_arg_map
///         self.default_op_map   = default_op_map
///
///     def __str__(self, op=None):
///         FMT_ARG = self.arg_map.get(op.__class__, self.default_arg_map)
///         FMT_OP  = self.op_map.get((self.lhs.__class__, self.rhs.__class__), self.default_op_map)
///         data    = FMT_OP(self.lhs.__str__(self), self.rhs.__str__(self))
///
///         return FMT_ARG(data)
/// ```
final class Op extends PythonClass {
  factory Op({
    required Object? lhs,
    required Object? rhs,
    required Object? arg_map,
    required Object? op_map,
    required Object? default_arg_map,
    required Object? default_op_map,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Op",
        Op.from,
        <Object?>[
          lhs,
          rhs,
          arg_map,
          op_map,
          default_arg_map,
          default_op_map,
        ],
        <String, Object?>{},
      );

  Op.from(super.pythonClass) : super.from();

  /// ## lhs (getter)
  Object? get lhs => getAttribute("lhs");

  /// ## lhs (setter)
  set lhs(Object? lhs) => setAttribute("lhs", lhs);

  /// ## rhs (getter)
  Object? get rhs => getAttribute("rhs");

  /// ## rhs (setter)
  set rhs(Object? rhs) => setAttribute("rhs", rhs);

  /// ## arg_map (getter)
  Object? get arg_map => getAttribute("arg_map");

  /// ## arg_map (setter)
  set arg_map(Object? arg_map) => setAttribute("arg_map", arg_map);

  /// ## op_map (getter)
  Object? get op_map => getAttribute("op_map");

  /// ## op_map (setter)
  set op_map(Object? op_map) => setAttribute("op_map", op_map);

  /// ## default_arg_map (getter)
  Object? get default_arg_map => getAttribute("default_arg_map");

  /// ## default_arg_map (setter)
  set default_arg_map(Object? default_arg_map) =>
      setAttribute("default_arg_map", default_arg_map);

  /// ## default_op_map (getter)
  Object? get default_op_map => getAttribute("default_op_map");

  /// ## default_op_map (setter)
  set default_op_map(Object? default_op_map) =>
      setAttribute("default_op_map", default_op_map);
}

/// ## Pow
///
/// ### python source
/// ```py
/// class Pow(Op):
///     def __init__(self, lhs, rhs):
///         POW_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT0,
///                 Exp: FMT1,
///               }
///
///         POW_OP_MAP = {
///
///         }
///
///
///         DEFAULT_POW_OP_MAP = lambda lhs, rhs: '\\sqrt[%s]{%s}' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, POW_ARG_MAP, POW_OP_MAP, FMT0,
///                     DEFAULT_POW_OP_MAP)
/// ```
final class Pow extends PythonClass {
  factory Pow({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Pow",
        Pow.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Pow.from(super.pythonClass) : super.from();
}

/// ## StringIO
final class StringIO extends PythonClass {
  factory StringIO() => PythonFfi.instance.importClass(
        "liblax",
        "StringIO",
        StringIO.from,
        <Object?>[],
      );

  StringIO.from(super.pythonClass) : super.from();

  /// ## closed (getter)
  Object? get closed => getAttribute("closed");

  /// ## closed (setter)
  set closed(Object? closed) => setAttribute("closed", closed);

  /// ## encoding (getter)
  Object? get encoding => getAttribute("encoding");

  /// ## encoding (setter)
  set encoding(Object? encoding) => setAttribute("encoding", encoding);

  /// ## errors (getter)
  Object? get errors => getAttribute("errors");

  /// ## errors (setter)
  set errors(Object? errors) => setAttribute("errors", errors);

  /// ## line_buffering (getter)
  Object? get line_buffering => getAttribute("line_buffering");

  /// ## line_buffering (setter)
  set line_buffering(Object? line_buffering) =>
      setAttribute("line_buffering", line_buffering);

  /// ## newlines (getter)
  Object? get newlines => getAttribute("newlines");

  /// ## newlines (setter)
  set newlines(Object? newlines) => setAttribute("newlines", newlines);

  /// ## close (getter)
  Object? get close => getAttribute("close");

  /// ## close (setter)
  set close(Object? close) => setAttribute("close", close);

  /// ## detach (getter)
  Object? get detach => getAttribute("detach");

  /// ## detach (setter)
  set detach(Object? detach) => setAttribute("detach", detach);

  /// ## fileno (getter)
  Object? get fileno => getAttribute("fileno");

  /// ## fileno (setter)
  set fileno(Object? fileno) => setAttribute("fileno", fileno);

  /// ## flush (getter)
  Object? get flush => getAttribute("flush");

  /// ## flush (setter)
  set flush(Object? flush) => setAttribute("flush", flush);

  /// ## getvalue (getter)
  Object? get getvalue => getAttribute("getvalue");

  /// ## getvalue (setter)
  set getvalue(Object? getvalue) => setAttribute("getvalue", getvalue);

  /// ## isatty (getter)
  Object? get isatty => getAttribute("isatty");

  /// ## isatty (setter)
  set isatty(Object? isatty) => setAttribute("isatty", isatty);

  /// ## read (getter)
  Object? get read => getAttribute("read");

  /// ## read (setter)
  set read(Object? read) => setAttribute("read", read);

  /// ## readable (getter)
  Object? get readable => getAttribute("readable");

  /// ## readable (setter)
  set readable(Object? readable) => setAttribute("readable", readable);

  /// ## readline (getter)
  Object? get readline => getAttribute("readline");

  /// ## readline (setter)
  set readline(Object? readline) => setAttribute("readline", readline);

  /// ## readlines (getter)
  Object? get readlines => getAttribute("readlines");

  /// ## readlines (setter)
  set readlines(Object? readlines) => setAttribute("readlines", readlines);

  /// ## seek (getter)
  Object? get seek => getAttribute("seek");

  /// ## seek (setter)
  set seek(Object? seek) => setAttribute("seek", seek);

  /// ## seekable (getter)
  Object? get seekable => getAttribute("seekable");

  /// ## seekable (setter)
  set seekable(Object? seekable) => setAttribute("seekable", seekable);

  /// ## tell (getter)
  Object? get tell => getAttribute("tell");

  /// ## tell (setter)
  set tell(Object? tell) => setAttribute("tell", tell);

  /// ## truncate (getter)
  Object? get truncate => getAttribute("truncate");

  /// ## truncate (setter)
  set truncate(Object? truncate) => setAttribute("truncate", truncate);

  /// ## writable (getter)
  Object? get writable => getAttribute("writable");

  /// ## writable (setter)
  set writable(Object? writable) => setAttribute("writable", writable);

  /// ## write (getter)
  Object? get write => getAttribute("write");

  /// ## write (setter)
  set write(Object? write) => setAttribute("write", write);

  /// ## writelines (getter)
  Object? get writelines => getAttribute("writelines");

  /// ## writelines (setter)
  set writelines(Object? writelines) => setAttribute("writelines", writelines);
}

/// ## Sub
///
/// ### python source
/// ```py
/// class Sub(Op):
///     def __init__(self, lhs, rhs):
///         SUB_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT1,
///                 Pow: FMT1,
///                 Exp: FMT1,
///               }
///
///         SUB_OP_MAP = {
///
///         }
///
///         DEFAULT_SUB_OP_MAP = lambda rhs, lhs: '%s-%s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, SUB_ARG_MAP, SUB_OP_MAP, FMT0,
///                     DEFAULT_SUB_OP_MAP)
/// ```
final class Sub extends PythonClass {
  factory Sub({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Sub",
        Sub.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Sub.from(super.pythonClass) : super.from();
}

/// ## Sum
///
/// ### python source
/// ```py
/// class Sum(Op):
///     def __init__(self, lhs, rhs):
///         SUM_ARG_MAP = {
///                     Chk: FMT0,
///                     Div: FMT0,
///                     Sum: FMT0,
///                     Sub: FMT0,
///                     Mul: FMT1,
///                     Pow: FMT1,
///                     Exp: FMT1,
///               }
///
///         SUM_OP_MAP = {
///
///         }
///
///         DEFAULT_SUM_OP_MAP = lambda rhs, lhs: '%s+%s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, SUM_ARG_MAP, SUM_OP_MAP, FMT0,
///                     DEFAULT_SUM_OP_MAP)
/// ```
final class Sum extends PythonClass {
  factory Sum({
    required Object? lhs,
    required Object? rhs,
  }) =>
      PythonFfi.instance.importClass(
        "liblax",
        "Sum",
        Sum.from,
        <Object?>[
          lhs,
          rhs,
        ],
        <String, Object?>{},
      );

  Sum.from(super.pythonClass) : super.from();
}

/// ## liblax
///
/// ### python source
/// ```py
/// from .parser import *
/// ```
final class liblax extends PythonModule {
  liblax.from(super.pythonModule) : super.from();

  static liblax import() => PythonFfi.instance.importModule(
        "liblax",
        liblax.from,
      );

  /// ## FMT0
  ///
  /// ### python source
  /// ```py
  /// FMT0 = lambda data: data
  /// ```
  Object? FMT0({
    required Object? data,
  }) =>
      getFunction("FMT0").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## FMT1
  ///
  /// ### python source
  /// ```py
  /// FMT1 = lambda data: '\\left(%s\\right)' % data
  /// ```
  Object? FMT1({
    required Object? data,
  }) =>
      getFunction("FMT1").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## build
  ///
  /// ### python source
  /// ```py
  /// def build(data):
  ///     result = []
  ///     for num, val, _, _, _  in split(StringIO(data).readline):
  ///         if num == NUMBER:
  ///             result.extend([(NAME, 'Num'), (OP, '('),
  ///             (STRING, str(val)), (OP, ')')])
  ///         elif num == NAME and not val.startswith('_'):
  ///             result.extend([(NAME, 'Chk'),
  ///             (OP, '('), (OP, "'"),
  ///             (STRING, str(val)), (OP, "'"), (OP, ')')])
  ///         else:
  ///             result.append((num, val))
  ///     return untokenize(result)
  /// ```
  Object? build({
    required Object? data,
  }) =>
      getFunction("build").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## run
  ///
  /// ### python source
  /// ```py
  /// def run(data):
  ///     return eval(build(data))
  /// ```
  Object? run({
    required Object? data,
  }) =>
      getFunction("run").call(
        <Object?>[
          data,
        ],
        kwargs: <String, Object?>{},
      );

  /// ## core
  core get $core => core.import();

  /// ## parser
  parser get $parser => parser.import();

  /// ## NAME (getter)
  Object? get NAME => getAttribute("NAME");

  /// ## NAME (setter)
  set NAME(Object? NAME) => setAttribute("NAME", NAME);

  /// ## NUMBER (getter)
  Object? get NUMBER => getAttribute("NUMBER");

  /// ## NUMBER (setter)
  set NUMBER(Object? NUMBER) => setAttribute("NUMBER", NUMBER);

  /// ## OP (getter)
  Object? get OP => getAttribute("OP");

  /// ## OP (setter)
  set OP(Object? OP) => setAttribute("OP", OP);

  /// ## STRING (getter)
  Object? get STRING => getAttribute("STRING");

  /// ## STRING (setter)
  set STRING(Object? STRING) => setAttribute("STRING", STRING);
}

/// ## core
///
/// ### python source
/// ```py
/// FMT0 = lambda data: data
/// FMT1 = lambda data: '\\left(%s\\right)' % data
///
/// class Function:
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, name, exp):
///         self.name = name
///         self.exp  = exp
///
///     def __str__(self, op=None):
///         return '%s\\left(%s\\right)' % (self.name, self.exp.__str__(self))
///
/// class Chk:
///     def __call__(self, exp):
///         return Function(self, exp)
///
///     def __init__(self, val):
///         self.val = val
///
///     def __add__(self, other):
///         return Sum(self, other)
///
///     def __radd__(self, other):
///         return Sum(other, self)
///
///     def __sub__(self, other):
///         return Sub(self, other)
///
///     def __rsub__(self, other):
///         return Sub(other, self)
///
///     def __str__(self, op=None):
///         return self.val
///
///     def __mul__(self, other):
///         return Mul(self, other)
///
///     def __rmul__(self, other):
///         return Mul(other, self)
///
///     def __truediv__(self, other):
///         return Div(self, other)
///
///     def __rtruediv__(self, other):
///         return Div(other, self)
///
///     def __pow__(self, other):
///         return Exp(other, self)
///
///     def __rpow__(self, other):
///         return Exp(self, other)
///
///     def __rxor__(self, other):
///         return Pow(self, other)
///
///     def __xor__(self, other):
///         return Pow(other, self)
///
/// class Num(Chk):
///     def __init__(self, val):
///         Chk.__init__(self, val)
///
/// class Block:
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, exp0, exp1):
///         self.exp0 = exp0
///         self.exp1  = exp1
///
///     def __str__(self, op=None):
///         tmp = '\\left(%s\\right)'
///         lhs = self.exp0.__str__(self)
///         lhs = tmp % lhs if not isinstance(self.exp0, Block) else lhs
///         rhs = self.exp1.__str__(self)
///         rhs = tmp % rhs if not isinstance(self.exp1, Block) else rhs
///         return '%s%s' % (lhs, rhs)
///
/// class Op(Chk):
///     def __call__(self, exp):
///         return Block(self, exp)
///
///     def __init__(self, lhs, rhs, arg_map, op_map, default_arg_map, default_op_map):
///         self.lhs              = lhs
///         self.rhs              = rhs
///         self.arg_map          = arg_map
///         self.op_map           = op_map
///         self.default_arg_map  = default_arg_map
///         self.default_op_map   = default_op_map
///
///     def __str__(self, op=None):
///         FMT_ARG = self.arg_map.get(op.__class__, self.default_arg_map)
///         FMT_OP  = self.op_map.get((self.lhs.__class__, self.rhs.__class__), self.default_op_map)
///         data    = FMT_OP(self.lhs.__str__(self), self.rhs.__str__(self))
///
///         return FMT_ARG(data)
///
/// class Sum(Op):
///     def __init__(self, lhs, rhs):
///         SUM_ARG_MAP = {
///                     Chk: FMT0,
///                     Div: FMT0,
///                     Sum: FMT0,
///                     Sub: FMT0,
///                     Mul: FMT1,
///                     Pow: FMT1,
///                     Exp: FMT1,
///               }
///
///         SUM_OP_MAP = {
///
///         }
///
///         DEFAULT_SUM_OP_MAP = lambda rhs, lhs: '%s+%s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, SUM_ARG_MAP, SUM_OP_MAP, FMT0,
///                     DEFAULT_SUM_OP_MAP)
///
///
/// class Sub(Op):
///     def __init__(self, lhs, rhs):
///         SUB_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT1,
///                 Pow: FMT1,
///                 Exp: FMT1,
///               }
///
///         SUB_OP_MAP = {
///
///         }
///
///         DEFAULT_SUB_OP_MAP = lambda rhs, lhs: '%s-%s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, SUB_ARG_MAP, SUB_OP_MAP, FMT0,
///                     DEFAULT_SUB_OP_MAP)
///
///
///
/// class Mul(Op):
///     def __init__(self, lhs, rhs):
///
///         MUL_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT1,
///                 Exp: FMT1,
///               }
///
///         MUL_OP_MAP = {
///
///         }
///
///         DEFAULT_MUL_OP_MAP = lambda rhs, lhs: '%s\cdot %s' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, MUL_ARG_MAP, MUL_OP_MAP, FMT0,
///                     DEFAULT_MUL_OP_MAP)
///
///
/// class Div(Op):
///     def __init__(self, lhs, rhs):
///         DIV_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT1,
///                 Exp: FMT1,
///
///               }
///
///         DIV_OP_MAP = {
///
///         }
///
///
///         DEFAULT_DIV_OP_MAP = lambda rhs, lhs: '\\frac{%s}{%s}' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, DIV_ARG_MAP, DIV_OP_MAP, FMT0,
///                     DEFAULT_DIV_OP_MAP)
///
///
/// class Pow(Op):
///     def __init__(self, lhs, rhs):
///         POW_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT0,
///                 Exp: FMT1,
///               }
///
///         POW_OP_MAP = {
///
///         }
///
///
///         DEFAULT_POW_OP_MAP = lambda lhs, rhs: '\\sqrt[%s]{%s}' % (rhs, lhs)
///
///         Op.__init__(self, lhs, rhs, POW_ARG_MAP, POW_OP_MAP, FMT0,
///                     DEFAULT_POW_OP_MAP)
///
/// class Exp(Op):
///     def __init__(self, lhs, rhs):
///         DEFAULT_EXP_OP_MAP = lambda lhs, rhs: '{%s}^{%s}' % (rhs, lhs)
///
///         EXP_ARG_MAP = {
///                 Chk: FMT0,
///                 Div: FMT0,
///                 Sum: FMT0,
///                 Sub: FMT0,
///                 Mul: FMT0,
///                 Pow: FMT0,
///                 Exp: FMT1,
///
///               }
///
///         EXP_OP_MAP = {
///
///         }
///
///         Op.__init__(self, lhs, rhs, EXP_ARG_MAP, EXP_OP_MAP, FMT0,
///                     DEFAULT_EXP_OP_MAP)
/// ```
final class core extends PythonModule {
  core.from(super.pythonModule) : super.from();

  static core import() => PythonFfi.instance.importModule(
        "liblax.core",
        core.from,
      );
}

/// ## parser
///
/// ### python source
/// ```py
/// from tokenize import generate_tokens as split
/// from tokenize import NUMBER, NAME, STRING, OP, untokenize
/// from io import StringIO
/// from .core import *
///
/// def build(data):
///     result = []
///     for num, val, _, _, _  in split(StringIO(data).readline):
///         if num == NUMBER:
///             result.extend([(NAME, 'Num'), (OP, '('),
///             (STRING, str(val)), (OP, ')')])
///         elif num == NAME and not val.startswith('_'):
///             result.extend([(NAME, 'Chk'),
///             (OP, '('), (OP, "'"),
///             (STRING, str(val)), (OP, "'"), (OP, ')')])
///         else:
///             result.append((num, val))
///     return untokenize(result)
///
/// def run(data):
///     return eval(build(data))
/// ```
final class parser extends PythonModule {
  parser.from(super.pythonModule) : super.from();

  static parser import() => PythonFfi.instance.importModule(
        "liblax.parser",
        parser.from,
      );

  /// ## NAME (getter)
  Object? get NAME => getAttribute("NAME");

  /// ## NAME (setter)
  set NAME(Object? NAME) => setAttribute("NAME", NAME);

  /// ## NUMBER (getter)
  Object? get NUMBER => getAttribute("NUMBER");

  /// ## NUMBER (setter)
  set NUMBER(Object? NUMBER) => setAttribute("NUMBER", NUMBER);

  /// ## OP (getter)
  Object? get OP => getAttribute("OP");

  /// ## OP (setter)
  set OP(Object? OP) => setAttribute("OP", OP);

  /// ## STRING (getter)
  Object? get STRING => getAttribute("STRING");

  /// ## STRING (setter)
  set STRING(Object? STRING) => setAttribute("STRING", STRING);
}
