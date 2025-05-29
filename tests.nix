{
  my-lib,
  test-lib,
  ...
}: let
  inherit (test-lib) assertEq;
  inherit (my-lib) hello;
in {
  simple = assertEq (hello "Ivan") "Hello, Ivan!";

  multiple-test = [
    (assertEq (hello "John") "Hello, John!")
    (assertEq (hello "Peter") "Hello, Peter!")
  ];
}
