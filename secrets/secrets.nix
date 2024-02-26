let
  jon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3bnlKpGO7eqZFafiLxJVG0TYyleVfuO1C9Q2q0QHJg";
  kara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFhVkbNk0hYPZOu4SlBwD1RXd78PmiD21Yen2j8JgT6Z";
  thor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqnwVNoWVkTJxUJ1yZh64wKBYaij1IwXUA3PRE3/lIx";
  users = [ jon ];
in
{
  "kara-borgbase-ssh.age".publicKeys = users ++ [ kara ];
  "kara-borgbase-passphrase.age".publicKeys = users ++ [ kara ];

  "thor-digitalocean.age".publicKeys = users ++ [ thor ];
  "thor-borgbase-ssh.age".publicKeys = users ++ [ thor ];
  "thor-borgbase-passphrase.age".publicKeys = users ++ [ thor ];
  "thor-libations-tskey.age".publicKeys = users ++ [ thor ];
  "thor-libations-recipes.age".publicKeys = users ++ [ thor ];

  "thor-dashboard-env.age".publicKeys = users ++ [ thor ];
}
