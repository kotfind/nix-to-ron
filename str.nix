{pkgs, ...} @ args: let
  inherit (pkgs) lib;
  cmp = import ./cmp.nix args;
  canonize = (import ./canonize.nix args).canonize;

  inherit (lib.lists) all findFirst;
  inherit (lib.strings) concatMapStringsSep concatMapAttrsStringSep;
  inherit (builtins) isBool replaceStrings;
  inherit
    (cmp)
    isRonNum
    isRonBool
    isRonChar
    isRonStr
    isRonOpt
    isRonTup
    isRonLst
    isRonStruct
    isRonMap
    isRonUnit
    ;

  case = cond: value: {inherit cond value;};

  switch = caseList:
    assert all ({
      cond,
      value,
    }:
      isBool cond)
    caseList; let
      case =
        findFirst
        ({cond, ...}: cond)
        (throw "non of case confitions were true")
        caseList;
    in
      case.value;

  toRonString = v_: let
    v = canonize v_;
    val = v.value;
    name =
      if v.name or null != null
      then v.name
      else "";

    csv = list: concatMapStringsSep "," toRonString list;

    # TODO: more escapes & \x{...}
    esc =
      replaceStrings
      ["\\" "\"" "\n" "\t"]
      ["\\\\" "\\\"" "\\n" "\\t"];

    fromNum = case (isRonNum v) (toString val);

    fromBool = case (isRonBool v) (
      if val
      then "true"
      else "false"
    );

    fromChar = case (isRonChar v) "'${esc val}'";

    fromStr = case (isRonStr v) "\"${esc val}\"";

    fromNone = case (isRonOpt v && !v.has_value) "None";
    fromSome = case (isRonOpt v && v.has_value) "Some(${toRonString val})";

    # XXX: empty tup
    fromTup = case (isRonTup v) "${name}(${csv val})";

    # XXX: empty lst
    fromLst = case (isRonLst v) "[${csv val}]";

    fromStruct = case (isRonStruct v) (let
      toPair = name: value: "${name}:${toRonString value}";
      inner = concatMapAttrsStringSep "," toPair val;
    in "${name}(${inner})");

    fromMap = case (isRonMap v) (let
      toPair = {
        name,
        value,
      }: "${toRonString name}:${toRonString value}";
      inner = concatMapStringsSep "," toPair val;
    in "{${inner}}");

    fromUnit = case (isRonUnit v) "${val}";

    otherwise =
      case true (throw "got value of unsupported type");
  in
    switch [
      fromNum
      fromBool
      fromChar
      fromStr
      fromNone
      fromSome
      fromTup
      fromLst
      fromStruct
      fromMap
      fromUnit

      otherwise
    ];
in {
  inherit toRonString;
}
