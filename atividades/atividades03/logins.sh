#!/bin/bash

# -v pega o inverso
grep -Ev 'sshd' /home/compartilhado/auth.log.1

grep -E 'pam_unix(sshd:session): session opened' /home/compartilhado/auth.log.1

grep -E 'sshd([[:alnum:]]|[[:punct:]]|[[:space:]])*root' /home/compartilhado/auth.log.1

grep -E 'Dec[[:space:]]*4[[:space:]]*1[8-9]:[0-9]{2}:[0-9]{2}([[:alnum:]]|[[:punct:]]|[[:space:]])*sshd:session): session opened' /home/compartilhado/auth.log.1
