alias sb='fzf_second_brain'

sbn() {
    e "${SECOND_BRAIN}/0 Inbox/$(openssl rand -hex 4).md"
}
