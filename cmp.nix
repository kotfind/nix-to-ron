{...} @ args: let
  canonize = (import ./canonize.nix args).canonize;

  inherit
    (builtins)
    isFloat
    isInt
    isString
    isBool
    isAttrs
    ;

  isRon = v:
    (isAttrs v && v.type == "ron")
    || isString v
    || isFloat v
    || isInt v
    || isBool v;

  isRonOfKind = kind: v: (canonize v).kind == kind;

  isRonNum = isRonOfKind "num";
  isRonBool = isRonOfKind "bool";
  isRonChar = isRonOfKind "char";
  isRonStr = isRonOfKind "str";
  isRonOpt = isRonOfKind "opt";
  isRonTup = isRonOfKind "tup";
  isRonLst = isRonOfKind "lst";
  isRonStruct = isRonOfKind "struct";
  isRonMap = isRonOfKind "map";
  isRonUnit = isRonOfKind "unit";
in {
  inherit
    isRon
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
}
