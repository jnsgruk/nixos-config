{ pkgs, ... }:
{
  launchd = {
    user = {
      agents = {
        openssh-ssh-agent = {
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            ProgramArguments = [
              "sh"
              "-c"
              "${pkgs.openssh}/bin/ssh-agent -D -a ~/.ssh/agent"
            ];
          };
        };
      };
    };
  };
}
