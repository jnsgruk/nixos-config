{ ... }: {
  assigns = {
    "1" = [
      { class = "[Ff]irefox"; }
      { app_id = "firefox"; }
    ];
    "2" = [
      { title = "- Obsidian v*"; }
      { app_id = "google-chrome"; }
    ];
    "3" = [
      { class = "[Mm]attermost"; }
      { app_id = "[Mm]attermost"; }
      { title = "[Rr]ambox"; }
    ];
    "4" = [
      { class = "[Ss]ignal"; }
      { app_id = "[Ss]ignal"; }
      { class = "[Dd]iscord"; }
      { title = "[Dd]iscord"; }
    ];
    "5" = [
      { class = "[Cc]ode"; }
      { app_id = "[Cc]ode|code-url-handler"; }
    ];
  };

  commands = [
    # Floating window config
    {
      command = "floating enable";
      criteria = {
        window_role = "pop up|bubble|task_dialog|Preferences|page-info|Saves As|dialog|menu";
      };
    }
    {
      command = "floating enable";
      criteria = {
        app_id = "org.gnome.Nautilus|nm-connection-editor|pavucontrol|pinentry-qt|^code$";
      };
    }
    {
      command = "floating enable";
      criteria = {
        title = "Picture-in-picture|1Password";
      };
    }
    {
      command = "floating enable";
      criteria = {
        class = "1Password";
      };
    }
    # Floating & Sticky windows
    {
      command = "floating enable sticky";
      criteria = { window_role = "Open Files|Open Folder|File Operation Progress"; };
    }
    # Sticky windows
    {
      command = "sticky enable";
      criteria = { app_id = "^code$"; };
    }
    {
      command = "sticky enable";
      criteria = { instance = "file_progress"; };
    }
    {
      command = "sticky enable";
      criteria = { class = "info|Mate-color-select|gcolor2|timesup|QtPass|GtkFileChooserDialog"; };
    }
    # Inhibit idle when there is a fullscreen app
    {
      command = "inhibit_idle fullscreen";
      criteria = { class = ".*"; };
    }
  ];
}
