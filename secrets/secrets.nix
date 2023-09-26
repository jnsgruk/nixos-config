let
  jon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3bnlKpGO7eqZFafiLxJVG0TYyleVfuO1C9Q2q0QHJg";
  users = [ jon ];
  thor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqnwVNoWVkTJxUJ1yZh64wKBYaij1IwXUA3PRE3/lIx";
in
{
  "digitalocean.age".publicKeys = users ++ [ thor ];
  "borgbase-ssh.age".publicKeys = users ++ [ thor ];
  "borgbase-passphrase.age".publicKeys = users ++ [ thor ];
}
