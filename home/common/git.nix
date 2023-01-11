{pkgs, ...}: {
  programs.git = {
    enable = true;
    
    userEmail = "jon@sgrs.uk";
    userName = "Jon Seager";
  };
}