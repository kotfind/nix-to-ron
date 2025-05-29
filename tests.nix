{
  my-lib,
  test-lib,
  ...
}: let
  inherit (test-lib) assertEq;
  inherit (my-lib) hello;
in {
  simple = assertEq (hello "Ivan") "Hello, Ivan!";

  multiple-test = {
    x = {
      z = assertEq (hello "John") "Hello, john!"; # <- this one should fail
    };
    y = assertEq (hello "Peter") "Hello, Peter!";
  };
}
