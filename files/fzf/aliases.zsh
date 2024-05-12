open_with_fzf() {
	(cd "${HOME}/Developer" && fd -t f | fzf -m --print0 | xargs -0 nvim)
}

cd_with_fzf() {
    local cur_dir="${PWD}"
    cd "${HOME}/Developer"
	dir="$(fd -t d -I --strip-cwd-prefix | fzf --preview="tree -L 1 {}" --bind="tab:toggle-preview" --preview-window=:hidden)"
    dir="${HOME}/Developer/${dir}"
	if [[ -n "$dir" ]]; then
		cd "${dir}" || return
	fi
    cd "${cur_dir}"
}

pass_with_fzf() {
	password="$(gopass ls --flat | fzf -m)"
	if [[ -n $password ]]; then
		gopass show -c "$password" 2>/dev/null
	fi
}

fzf_second_brain() {
	(cd "${SECOND_BRAIN}" && fd -t f -IH --exclude ".git" --exclude ".obsidian" --exclude "attachments" --exclude "_resources" | fzf -m --print0 | xargs -0 e)
}
