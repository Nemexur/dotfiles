{
  lib,
  config,
  myVars,
  ...
}: {
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ${config.home.homeDirectory}/.gitconfig
  '';

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
    hosts = {
      "github.com" = {
        "users" = {
          "nemexur" = null;
        };
        "user" = "nemexur";
      };
    };
  };

  programs.git = {
    enable = true;
    includes = [
      {
        path = "~/Developer/work/.gitconfig";
        condition = "gitdir:~/Developer/work/";
      }
    ];
    settings = {
      user.name = myVars.git.name;
      user.email = myVars.git.email;
      # TODO: Add gpg sign

      hub.protocol = "https";
      alias = {
        b = "branch";
        s = "status";
        c = "commit";
        ca = "commit -a";
        cm = "commit -m";
        co = "checkout";
        cd = "git diff --color | sed \"s/^\([^-+ ]*\)[-+ ]/\\1/\" | cat";
        count = "shortlog -sn";
        undo = "reset --soft HEAD~";
        amend = "commit --amend";
        glog = "log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      core = {
        excludesfile = "~/.gitignore";
        editor = "nvim";
      };
      apply = {
        whitespace = "nowarn";
      };
      mergetool = {
        # Clean up backup files created by merge tools on tool exit
        keepBackup = false;
        # Clean up temp files created by merge tools on tool exit
        keepTemporaries = false;
        # Put the temp files in a dedicated dir anyway
        writeToTemp = true;
        # Auto-accept file prompts when launching merge tools
        prompt = false;
      };
      difftool = {
        prompt = false;
      };
      help = {
        autocorrect = 1;
      };
      fetch = {
        prune = true;
      };
      merge = {
        # Disable fast-forward merges as default merge strategy.
        # Force explicit call of git merge --ff ….
        ff = true;
        conflictStyle = "zdiff3";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
      };
      rebase = {
        # Rebase advanced usage.
        # Automagically reorder and prefix your commands while doing an interactive
        # rebase. This has to be used with --fixup and/or --squash options for
        # git commit.
        autoSquash = true;
        # Automatically stash current WD and stage when running rebase
        # then you won't have to manually git stash push and git stash pop
        # after and before your rebase.
        autoStash = true;
      };
      status = {
        # Display submodule rev change summaries in status
        submoduleSummary = true;
        # Recursively traverse untracked directories to display all contents
        showUntrackedFiles = "all";
      };
    };
  };
  # A syntax-highlighting pager for git, diff, grep, and blame output
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      diff-so-fancy = true;
      line-numbers = true;
      true-color = "always";
      # features => named groups of settings, used to keep related settings organized
      # features = "";
    };
  };

  # Git terminal UI (written in go).
  programs.lazygit.enable = true;
}
