{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "testdb" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # Allow local connections via Unix socket
      local   all   all                trust

      # Allow IPv4 connections with password authentication
      host    all   all   127.0.0.1/32   scram-sha-256

      # Allow IPv6 connections with password authentication
      host    all   all   ::1/128        scram-sha-256
    '';
  };
}
