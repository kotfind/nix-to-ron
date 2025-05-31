{pkgs} @ args: let
  inherit (pkgs) lib;
  cmp = import ./cmp.nix args;

  inherit
    (builtins)
    isFloat
    isInt
    isString
    isBool
    stringLength
    ;
  inherit (cmp) isRon;
  inherit (lib.lists) all;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.trivial) id;

  # -------------------- Helpers --------------------

  val = kind: value: {
    type = "ron";
    inherit kind value;
  };

  xval = kind: value: extra: val kind value // extra;

  # -------------------- Basic --------------------

  num = v:
    assert isFloat v || isInt v;
      val "num" v;

  bool = v:
    assert isBool v;
      val "bool" v;

  char = v:
    assert isString v && stringLength v == 1;
      val "char" v;

  str = v:
    assert isString v;
      val "str" v;

  # -------------------- Opt --------------------

  some = v:
    assert isRon v;
      xval "opt" v {has_value = true;};

  none = xval "opt" null {has_value = false;};

  # -------------------- Tup --------------------

  ntup = name: v:
    assert all isRon v;
      xval "tup" v {inherit name;};

  tup = ntup null;

  # -------------------- Lst --------------------

  lst = v:
    assert all isRon v;
      val "lst" v;

  # -------------------- Struct --------------------

  nstruct = name: v:
    assert all id (mapAttrsToList (_: isRon) v);
      xval "struct" v {inherit name;};

  struct = nstruct null;

  # -------------------- Map --------------------

  map_ = v:
    assert all (
      {
        name,
        value,
      }:
        isRon name && isRon value
    )
    v;
      val "map" v;

  # -------------------- Unit --------------------

  unit = v:
    assert isString v;
      val "unit" v;
in {
  inherit
    num
    bool
    char
    str
    some
    none
    ntup
    tup
    lst
    nstruct
    struct
    map_
    unit
    ;
}
