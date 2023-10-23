_: {

  home.file.".config/git/allowed_signers".text = ''
    jon@sgrs.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB9bIEMgZVBCDxBWQ4m4hQP6ZZp0P3TfzjzcgUOdbYDLAAAABHNzaDo= YK5C
    jon@sgrs.uk sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBC8cs1B64XqEswY5pART6yERbjUMB7RdQdT38dgkZT6AAAABHNzaDo= YK5
    jon.seager@canonical.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIB9bIEMgZVBCDxBWQ4m4hQP6ZZp0P3TfzjzcgUOdbYDLAAAABHNzaDo= YK5C
    jon.seager@canonical.com sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBC8cs1B64XqEswY5pART6yERbjUMB7RdQdT38dgkZT6AAAABHNzaDo= YK5
  '';

  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;

      userEmail = "jon@sgrs.uk";
      userName = "Jon Seager";

      # When the working directory is under ~/code/canonical then sign-off commits
      # with Canonical email address.
      includes = [{
        condition = "gitdir:~/code/canonical/";
        contents.user.email = "jon.seager@canonical.com";
      }];

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
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

      ignores = [
        "*.fdb_latexmk"
        "*.fls"
        "*.aux"
        "*.glo"
        "*.idx"
        "*.log"
        "*.toc"
        "*.ist"
        "*.acn"
        "*.acr"
        "*.alg"
        "*.bbl"
        "*.blg"
        "*.dvi"
        "*.glg"
        "*.gls"
        "*.ilg"
        "*.ind"
        "*.lof"
        "*.lot"
        "*.maf"
        "*.mtc"
        "*.mtc1"
        "*.out"
        "*.synctex.gz"
        "*.module.js"
        "*.routing.js"
        "*.component.js"
        "*.service.js"
        "*.map"
        ".DS_Store"
        ".vscode/"
        "node_modules/"
        "dist/"
        "bin/"
        ".tox/"
        ".mypy*/"
        "venv/"
        ".venv/"
        "__pycache__/"
      ];
    };
  };
}
