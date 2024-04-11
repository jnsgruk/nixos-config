{ lib, ... }:
let
  inherit (lib) isBool isInt;
  inherit (builtins)
    toString
    isList
    isString
    concatStringsSep
    concatMap
    removeAttrs
    isAttrs
    ;
  inherit (lib.attrsets) filterAttrs;

  # Copied from https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix
  mkValueString =
    value:
    if isBool value then
      if value then "true" else "false"
    else if isInt value then
      toString value
    else if (value._type or "") == "literal" then
      value.value
    else if isString value then
      ''"${value}"''
    else if isList value then
      "[ ${concatStringsSep "," (map mkValueString value)} ]"
    else
      abort "Unhandled value type ${builtins.typeOf value}";

  mkKeyValue =
    {
      sep ? ": ",
      end ? ";",
    }:
    name: value: "${name}${sep}${mkValueString value}${end}";

  mkRasiSection =
    name: value:
    if isAttrs value then
      let
        toRasiKeyValue = lib.generators.toKeyValue { mkKeyValue = mkKeyValue { }; };
        # Remove null values so the resulting config does not have empty lines
        configStr = toRasiKeyValue (filterAttrs (_: v: v != null) value);
      in
      ''
        ${name} {
        ${configStr}}
      ''
    else
      (mkKeyValue {
        sep = " ";
        end = "";
      } name value)
      + "\n";
in
{
  toRasi =
    attrs:
    concatStringsSep "\n" (
      concatMap (lib.attrsets.mapAttrsToList mkRasiSection) [
        (filterAttrs (n: _: n == "@theme") attrs)
        (filterAttrs (n: _: n == "@import") attrs)
        (removeAttrs attrs [
          "@theme"
          "@import"
        ])
      ]
    );
}
