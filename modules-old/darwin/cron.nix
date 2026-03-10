# TODO: Move to home manager to manage scripts. Make it an option
# {
#   lib,
#   myVars,
#   ...
# }: let
#   tmuxKillSession = lib.path.append myVars.localBin "tmix-kill-session";
# in {
#   services.cron = {
#     enable = true;
#     systemCronJobs = [
#       "* */3 * * * ${tmuxKillSession} -v --filter 'dotfiles|ssh|skip' --inactive-mins-max 720"
#     ];
#   };
# }
