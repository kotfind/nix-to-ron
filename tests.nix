{
  my-lib,
  test-lib,
  ...
}: let
  inherit (builtins) replaceStrings;
  inherit (test-lib) assertEq;
  inherit (my-lib.str) toRonString;

  unws = replaceStrings [" " "\n" "\t"] ["" "" ""];
  assertCast = ronExpr: expectedStr:
    assertEq
    (toRonString ronExpr)
    (unws expectedStr);

  inherit
    (my-lib.gen)
    num
    bool
    char
    str
    some
    none
    tup
    ntup
    lst
    struct
    nstruct
    map_
    unit
    ;
in {
  num = [
    (assertCast 1 "1")
    (assertCast (num 1) "1")
  ];

  bool = [
    (assertCast true "true")
    (assertCast false "false")
    (assertCast (bool true) "true")
    (assertCast (bool false) "false")
  ];

  char = [
    (assertCast (char "a") "'a'")
    (assertCast (char "\n") "'\\n'")
  ];

  str = [
    (assertCast "abc" "\"abc\"")
    (assertCast "a\nbc" "\"a\\nbc\"")
    (assertCast (str "abc") "\"abc\"")
    (assertCast (str "a\nbc") "\"a\\nbc\"")
  ];

  opt = [
    (assertCast (some 10) "Some(10)")
    (assertCast (some (some (char "c"))) "Some(Some('c'))")

    (assertCast none "None")
    (assertCast (some none) "Some(None)")
  ];

  tup = [
    (assertCast (tup ["abc" 123 true]) "(\"abc\", 123, true)")
    (assertCast (tup [1 (tup [2 3])]) "(1, (2, 3))")

    (assertCast (ntup "MyTup" [1 2 3]) "MyTup(1, 2, 3)")
  ];

  lst = [
    (assertCast (lst ["abc" 123 true]) "[\"abc\", 123, true]")
    (assertCast (lst [1 (tup [2 3])]) "[1, (2, 3)]")
  ];

  struct = [
    (assertCast (struct {
      a = 1;
      b = true;
    }) "(a:1,b:true)")

    (assertCast (nstruct "MyStruct" {
      a = 1;
      b = true;
    }) "MyStruct(a:1,b:true)")
  ];

  map = [
    (
      assertCast
      (map_ [
        {
          name = "a";
          value = "b";
        }
        {
          name = "x";
          value = "y";
        }
      ])
      ''{ "a": "b", "x": "y" }''
    )
  ];

  unit = [
    (assertCast (unit "SMTH") "SMTH")
  ];
}
