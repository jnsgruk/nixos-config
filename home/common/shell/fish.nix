{
  catppuccin.fish.enable = true;

  programs = {
    fish = {
      enable = true;

      shellInit = ''
        set fish_greeting ""
        set -gx EDITOR hx
        set -gx SUDO_EDITOR hx
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
