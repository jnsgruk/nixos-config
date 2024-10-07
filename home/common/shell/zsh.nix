{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        catppuccin.enable = true;
      };

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
        bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
        # the ruff included in NixOS - needs to be run each time the tox enviroment is
        # recreated
        patch_tox_ruff() {
          for x in $(find .tox -name ruff -type f -print); do
            rm $x;
            ln -sf $(which ruff) $x;
          done
        }

        clean-crafts-lxc() {
          for CRAFT in snapcraft rockcraft charmcraft; do 
            lxc --project $CRAFT list -fcsv -cn | xargs lxc --project $CRAFT delete -f >/dev/null
          done
        }

        ubuntu() {
          BASE="''${BASE:-noble}"
          CONTAINER_NAME="''${CONTAINER_NAME:-ubuntu-''${BASE}-$(head -c 2 /dev/urandom | xxd -p -c 32)}"
          EPHEMERAL="''${EPHEMERAL:-true}"

          # Create the container, but don't start it
          lxc init -q "ubuntu:''${BASE}" "''${CONTAINER_NAME}"

          # Map host uid -> 1000 in the container, and host gid -> 1000
          printf "uid $(id -u) 1000\ngid $(id -g) 1000" | lxc config set -q "''${CONTAINER_NAME}" raw.idmap -

          # Mount the $HOME/data directory -> /home/ubuntu/data in the container
          lxc config device add -q "''${CONTAINER_NAME}" datadir disk source="''${HOME}/data" path=/home/ubuntu/data

          # Start the container, wait for cloud-init to finish
          lxc start "''${CONTAINER_NAME}"

          # Wait for the ubuntu user
          while ! lxc exec "''${CONTAINER_NAME}" -- id -u ubuntu &>/dev/null; do sleep 0.5; done

          # Fix broken permissions on ubuntu home directory
          lxc exec "''${CONTAINER_NAME}" -- sudo chown ubuntu:ubuntu /home/ubuntu

          # If extra args were specified, run them, else drop to a non-root shell
          if [[ -n "''${1:-}" ]]; then
            lxc exec "''${CONTAINER_NAME}" -- bash -c "$*"
          else
            lxc exec "''${CONTAINER_NAME}" -- sudo -u ubuntu -i bash
          fi

          # Delete the container when the command exits
          if [[ "''${EPHEMERAL}" == "true" ]]; then
            lxc delete -f "''${CONTAINER_NAME}"
          fi
        }

        ubuntu-vm() {
          BASE="''${BASE:-noble}"
          VM_NAME="''${VM_NAME:-ubuntu-''${BASE}-$(head -c 2 /dev/urandom | xxd -p -c 32)}"
          DISK="''${DISK:-100}"
          CPU="''${CPU:-16}"
          MEM="''${MEM:-32}"
          EPHEMERAL="''${EPHEMERAL:-true}"

          # Create the VM, but don't start it
          lxc init --vm "ubuntu:''${BASE}" "''${VM_NAME}" \
            -c limits.cpu="''${CPU}" -c limits.memory="''${MEM}GiB" -d root,size="''${DISK}GiB"

          # Mount the $HOME/data directory -> /home/ubuntu/data in the container
          lxc config device add "''${VM_NAME}" datadir disk source="''${HOME}/data" path=/home/ubuntu/data readonly=false

          # Start the container, wait for cloud-init to finish
          lxc start "''${VM_NAME}"

          # Wait for the ubuntu user
          while ! lxc exec "''${VM_NAME}" -- id -u ubuntu &>/dev/null; do sleep 0.5; done

          # Fix broken permissions on ubuntu home directory
          lxc exec "''${VM_NAME}" -- sudo chown ubuntu:ubuntu /home/ubuntu

          # If extra args were specified, run them, else drop to a non-root shell
          if [[ -n "''${1:-}" ]]; then
            lxc exec "''${VM_NAME}" -- bash -c "$*"
          else
            lxc exec "''${VM_NAME}" -- sudo -u ubuntu -i bash
          fi

          # Delete the container when the command exits
          if [[ "''${EPHEMERAL}" == "true" ]]; then
            lxc delete -f "''${VM_NAME}"
          fi
        }

        ubuntu-dev() {
          export EPHEMERAL=false
          export VM_NAME=dev
          ubuntu-vm
        }

        export EDITOR=vim
      '';

      shellAliases = {
        ls = "eza -gl --git --color=automatic";
        tree = "eza --tree";
        cat = "bat";

        lsusb = "cyme --headings";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        htop = "btm -b";
        neofetch = "fastfetch";

        tf = "terraform";
        tfi = "terraform init";
        tfp = "terraform plan";
        tfa = "terraform apply -auto-approve";
        tfd = "terraform destroy -auto-approve";
        tfo = "terraform output -json";

        wgu = "sudo wg-quick up";
        wgd = "sudo wg-quick down";

        ts = "tailscale";
        tst = "tailscale status";
        tsu = "tailscale up --ssh --operator=$USER";
        tsd = "tailscale down";

        js = "juju status";
        jsw = "juju status --watch 1s --color";
        jsrw = "juju status --watch 1s --color --relations";
        jdl = "juju debug-log";

        open = "xdg-open";
        k = "kubectl";

        opget = "op item get \"$(op item list --format=json | jq -r '.[].title' | fzf)\"";

        speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "nh clean all --keep-since 10d --keep 3";
        rln = "nh os switch /home/jon/nixos-config";
        rlh = "nh home switch /home/jon/nixos-config";
        rlb = "rln && rlh";
      };
    };
  };
}
