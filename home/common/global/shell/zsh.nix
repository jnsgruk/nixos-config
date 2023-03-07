{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        bindkey -e
        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char
        bindkey '^[[1;9C' forward-word # Ctrl+RightArrow
        bindkey '^[[1;9D' backward-word # Ctrl+LeftArrow
        bindkey "\033[1~" beginning-of-line
        bindkey "\033[4~" end-of-line

        zstyle :compinstall filename $HOME/.zshrc
        autoload -U colors && colors
        autoload -Uz compinit && compinit
        autoload -U +X bashcompinit && bashcompinit

        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        autoload -U promptinit
        promptinit

        # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
        # the ruff included in NixOS - needs to be run each time the tox enviroment is
        # recreated
        patch_tox_ruff() {
          for x in $(find .tox -name ruff -type f -print); do
            rm $x;
            ln -sf $(which ruff) $x; 
          done
        }

        export EDITOR=vim
      '';

      shellAliases = {
        ls = "exa -gl --git --color=automatic";
        cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        tf = "terraform";
        tfi = "terraform init";
        tfp = "terraform plan";
        tfa = "terraform apply -auto-approve";
        tfd = "terraform destroy -auto-approve";
        tfo = "terraform output -json";

        wgu = "sudo wg-quick up";
        wgd = "sudo wg-quick down";

        ts = "tailscale";
        tssh = "tailscale ssh";
        tst = "tailscale status";
        tsu = "tailscale up --ssh --operator = $USER";
        tsd = "tailscale down";

        js = "juju status";
        jsw = "juju status --watch 1s --color";
        jsrw = "juju status --watch 1s --color --relations";
        jdl = "juju debug-log";

        open = "xdg-open";
        k = "kubectl";

        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "sudo nix-collect-garbage -d";
        reload-nix = "sudo nixos-rebuild switch --flake /home/jon/nixos-config";
        reload-home = "home-manager switch --flake /home/jon/nixos-config";
      };
    };
  };
}
