{...}: let
  inherit
    (builtins)
    isFloat
    isInt
    isString
    isBool
    ;

  canonize = v:
    if isString v
    then {
      type = "ron";
      kind = "str";
      value = v;
    }
    else if isFloat v || isInt v
    then {
      type = "ron";
      kind = "num";
      value = v;
    }
    else if isBool v
    then {
      type = "ron";
      kind = "bool";
      value = v;
    }
    else if v.type == "ron"
    then v
    else throw "got value of unsupported type";
in {
  inherit canonize;
}
