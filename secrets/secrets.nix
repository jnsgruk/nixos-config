let
  jon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL3bnlKpGO7eqZFafiLxJVG0TYyleVfuO1C9Q2q0QHJg";
  users = [ jon ];

  kara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFhVkbNk0hYPZOu4SlBwD1RXd78PmiD21Yen2j8JgT6Z";
  thor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqnwVNoWVkTJxUJ1yZh64wKBYaij1IwXUA3PRE3/lIx";
  systems = [ kara thor ];
in
{
  "digitalocean.age".publicKeys = users ++ [ thor ];
}
