function reload {
	# Delete current completion cache
	command rm -f $_comp_dumpfile $ZSH_COMPDUMP

	# Old zsh versions don't have ZSH_ARGZERO
	local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}"
	# Check whether to run a login shell
	[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
}
