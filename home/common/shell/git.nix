{ pkgs, ... }:
{

  home.file.".config/git/allowed_signers".text = ''
    jon@sgrs.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB9bIEMgZVBCDxBWQ4m4hQP6ZZp0P3TfzjzcgUOdbYDLAAAABHNzaDo= YK5C
    jon@sgrs.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBC8cs1B64XqEswY5pART6yERbjUMB7RdQdT38dgkZT6AAAABHNzaDo= YK5
    jon.seager@canonical.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB9bIEMgZVBCDxBWQ4m4hQP6ZZp0P3TfzjzcgUOdbYDLAAAABHNzaDo= YK5C
    jon.seager@canonical.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBC8cs1B64XqEswY5pART6yERbjUMB7RdQdT38dgkZT6AAAABHNzaDo= YK5
    jnsgruk@ubuntu.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB9bIEMgZVBCDxBWQ4m4hQP6ZZp0P3TfzjzcgUOdbYDLAAAABHNzaDo= YK5C
    jnsgruk@ubuntu.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBC8cs1B64XqEswY5pART6yERbjUMB7RdQdT38dgkZT6AAAABHNzaDo= YK5
  '';

  home.packages = with pkgs; [ gh ];

  programs = {
    git = {
      enable = true;

      userEmail = "jon@sgrs.uk";
      userName = "Jon Seager";

      includes = [
        # When the working directory is under ~/code/canonical then sign-off commits
        # with Canonical email address.
        {
          condition = "gitdir:~/code/canonical/";
          contents.user.email = "jon.seager@canonical.com";
        }
        # When the working directory is under ~/code/snapcrafters then sign-off commits
        # with Ubuntu email address.
        {
          condition = "gitdir:~/code/snapcrafters/";
          contents.user.email = "jnsgruk@ubuntu.com";
        }
      ];

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        branch = {
          sort = "-committerdate";
        };
        push = {
          default = "matching";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        gpg = {
          format = "ssh";
          ssh = {
            defaultKeyCommand = "sh -c 'echo key::$(ssh-add -L | head -n1)'";
            allowedSignersFile = "~/.config/git/allowed_signers";
          };
        };
        commit = {
          gpgSign = true;
        };
        tag = {
          gpgSign = true;
        };
      };
    };
  };
}
