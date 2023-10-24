let
  jon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3bnlKpGO7eqZFafiLxJVG0TYyleVfuO1C9Q2q0QHJg";
  thor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqnwVNoWVkTJxUJ1yZh64wKBYaij1IwXUA3PRE3/lIx";
  users = [ jon ];
in
{
  "thor-digitalocean.age".publicKeys = users ++ [ thor ];
  "thor-borgbase-ssh.age".publicKeys = users ++ [ thor ];
  "thor-borgbase-passphrase.age".publicKeys = users ++ [ thor ];
}
