{
  flake.modules.darwin.systemSettings = {config, ...}: {
    # Add ability to used TouchID for sudo authentication
    security.pam.services.sudo_local.touchIdAuth = true;

    system = {
      stateVersion = config.systemConstants.darwinStateVersion;

      keyboard.enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`};

      defaults = {
        menuExtraClock.Show24Hour = true;

        # customize dock
        dock = {
          autohide = true; # automatically hide and show the dock
          show-recents = false; # disable recent apps
          mru-spaces = false; # do not automatically rearrange spaces based on most recent use.
          expose-group-apps = true; # group windows by application
        };

        # customize finder
        finder = {
          FXPreferredViewStyle = "Nlsv"; # prefer list view style in Finder
          AppleShowAllExtensions = true;
          FXEnableExtensionChangeWarning = false;
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowStatusBar = true;
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          FXDefaultSearchScope = "SCcf"; # search the current folder by default
          _FXShowPosixPathInTitle = true;
          _FXSortFoldersFirst = true;
        };

        # customize trackpad
        trackpad = {
          Clicking = true; # enable tap to click
          TrackpadRightClick = true; # enable two finger right click
          TrackpadThreeFingerDrag = true; # enable three finger drag
        };

        # Improve Screenshots management
        screencapture = {
          location = "~/Desktop/Screenshots";
          type = "png";
        };

        # Customize MacOS
        NSGlobalDomain = {
          "com.apple.swipescrolldirection" = true; # enable natural scrolling (default to true)
          "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
          AppleInterfaceStyle = "Dark"; # dark mode
          AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
          ApplePressAndHoldEnabled = true; # enable press and hold

          InitialKeyRepeat = 10; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
          KeyRepeat = 1; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

          NSAutomaticCapitalizationEnabled = false; # disable auto capitalization
          NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution
          NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution
          NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution
          NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction
          NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default
          NSNavPanelExpandedStateForSaveMode2 = true;
          NSWindowShouldDragOnGesture = true;
        };

        WindowManager = {
          EnableStandardClickToShowDesktop = false;
          StandardHideDesktopIcons = false;
          HideDesktop = false;
          StageManagerHideWidgets = false;
          StandardHideWidgets = false;
        };

        ActivityMonitor = {
          OpenMainWindow = true; # Show the main window when launching Activity Monitor
          IconType = 5; # Visualize CPU usage in the Activity Monitor Dock icon
          ShowCategory = 100; # Show all processes in Activity Monitor
          SortColumn = "CPUUsage"; # Sort Activity Monitor results by CPU usage
          SortDirection = 0; # Apply descending sort
        };

        loginwindow = {
          GuestEnabled = false; # disable guest user
          SHOWFULLNAME = true; # show full name in login window
        };
        # Disable the “Are you sure you want to open this application?” dialog
        LaunchServices.LSQuarantine = false;
        # All custom entries can be found by running `defaults read` command.
        # or `defaults read xxx` to read a specific domain.
        CustomUserPreferences = {
          # Add a context menu item for showing the Web Inspector in web views
          NSGlobalDomain.WebKitDeveloperExtras = true;
          # Avoid creating .DS_Store files on network or USB volumes
          "com.apple.desktopservices" = {
            DSDontWriteNetworkStores = true;
            DSDontWriteUSBStores = true;
          };
          "com.apple.screensaver" = {
            # Require password immediately after sleep or screen saver begins
            askForPassword = 1;
            askForPasswordDelay = 0;
          };
          "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
          # Prevent Photos from opening automatically when devices are plugged in
          "com.apple.ImageCapture".disableHotPlug = true;
          # Configure pinentry-touchid
          "org.gpgtools.common".UseKeychain = true;
          "com.apple.NetworkBrowser".BrowseAllInterfaces = "1";
          # Improve BlueTooth sound quality
          "com.apple.BluetoothAudioAgent" = {
            "Apple Bitpool Max (editable)" = 80;
            "Apple Bitpool Min (editable)" = 80;
            "Apple Initial Bitpool (editable)" = 80;
            "Apple Initial Bitpool Min (editable)" = 80;
            "Negotiated Bitpool" = 80;
            "Negotiated Bitpool Max" = 80;
            "Negotiated Bitpool Min" = 80;
          };
          # automatically switch to a new space when switching to the application
          ".GlobalPreferences".AppleSpacesSwitchOnActivate = true;
          # Keyboard Shortcuts
          "com.apple.symbolichotkeys" = {
            AppleSymbolicHotKeys = {
              "60" = {
                enabled = 1;
                value = {
                  parameters = [
                    32
                    49
                    1048576
                  ];
                  type = "standard";
                };
              };
              "61" = {
                enabled = 0;
                value = {
                  parameters = [
                    65535
                    36
                    1048576
                  ];
                  type = "standard";
                };
              };
              "64" = {
                enabled = 0;
                value = {
                  parameters = [
                    65535
                    49
                    262144
                  ];
                  type = "standard";
                };
              };
              "79" = {
                enabled = 1;
                value = {
                  parameters = [
                    65535
                    123
                    8650752
                  ];
                  type = "standard";
                };
              };
              "80" = {
                enabled = 1;
                value = {
                  parameters = [
                    65535
                    123
                    8781824
                  ];
                  type = "standard";
                };
              };
              "81" = {
                enabled = 1;
                value = {
                  parameters = [
                    65535
                    124
                    8650752
                  ];
                  type = "standard";
                };
              };
              "82" = {
                enabled = 1;
                value = {
                  parameters = [
                    65535
                    124
                    8781824
                  ];
                  type = "standard";
                };
              };
            };
          };
        };
      };
    };
  };
}
