{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "testdb" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
