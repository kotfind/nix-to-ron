{...} @ args: {
  gen = import ./gen.nix args;
  cmp = import ./cmp.nix args;
  str = import ./str.nix args;
  cannonize = import ./canonize.nix args;
}
