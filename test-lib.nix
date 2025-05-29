# @class TestingResult
# @field passed [string] list of passed test names
# @field failed [string] list of failed test names
#
{pkgs}: let
  inherit (pkgs) lib;

  inherit (builtins) tryEval deepSeq isBool trace;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.strings) concatStringsSep;
  inherit (pkgs) writeText;

  emptyTestingResult = {
    passed = [];
    failed = [];
  };

  # @param testingResult TestingResult
  # @param testName string name of passed test
  # @return TestingResult
  appendPassedTest = testingResult: testName: {
    passed = testingResult.passed ++ [testName];
    failed = testingResult.failed;
  };

  # @param testingResult TestingResult
  # @param testName string name of passed test
  # @return TestingResult
  appendFailedTest = testingResult: testName: {
    passed = testingResult.passed;
    failed = testingResult.failed ++ [testName];
  };

  # @param v any
  # @return bool
  canEval = v: (tryEval (deepSeq v null)).success;

  # @param testingResult TestingResult
  # @param testName string name of passed test
  # @param testBody any value, whose evaluation can possibly throw
  # @return TestingResult
  runTest = testingResult: testName: testBody:
    if canEval testBody
    then appendPassedTest testingResult testName
    else appendFailedTest testingResult testName;

  # @param tests attrs<any> test name -> test body (value, that may throw)
  # @return TestingResult
  runTests = tests: foldlAttrs runTest emptyTestingResult tests;

  # @param testingResult TestingResult
  # @return bool
  isSuccess = testingResult: testingResult.failed == [];

  # @param testingResult TestingResult
  # @return string
  toReport = testingResult: let
    passed = concatStringsSep ", " testingResult.passed;

    failed = concatStringsSep ", " testingResult.failed;

    verdict =
      if isSuccess testingResult
      then "All test passed!"
      else "SOME TESTS FAILED!";
  in
    concatStringsSep "\n" [
      ""
      "Passed: ${passed}"
      ""
      "Failed: ${failed}"
      ""
      verdict
    ];

  # @param testingResult TestingResult
  # @return string
  toReportOrThrow = testingResult: let
    report = toReport testingResult;
  in
    if isSuccess testingResult
    then report
    else throw report;

  # @param testingResult TestingResult
  # @return report derivation
  writeReportOrThrow = testingResult: let
    report = toReport testingResult;
  in
    if isSuccess testingResult
    then trace report (writeText "testing-report" report)
    else throw report;

  tryToString = v: let
    res = tryEval (toString v);
  in
    if res.success
    then res.value
    else "...";

  assertTrue = cond:
    assert isBool cond;
      if cond
      then null
      else throw "assert failed: cond is false";

  assertEq = lhs: rhs:
    if lhs == rhs
    then null
    else
      throw (concatStringsSep "\n" [
        "lhs != rhs"
        "lhs = ${tryToString lhs}"
        "rhs = ${tryToString rhs}"
      ]);
in {
  inherit
    runTests
    isSuccess
    toReport
    toReportOrThrow
    writeReportOrThrow
    assertTrue
    assertEq
    ;
}
