# Git configuration

This directory contains global Git configuration.

Work repos under `~/Forefront` use `gitconfig-work`, which delegates SSH key
selection to `ssh-command-work` so Azure DevOps can use a dedicated key while
other work remotes keep using the work GitHub key.
