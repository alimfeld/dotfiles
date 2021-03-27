# Dotfiles

## Installation

The dotfiles are installed with ansible:

```shell
ansible-pull -U https://github.com/alimfeld/dotfiles
```

or (once pulled):

```shell
cd ~/dotfiles
ansible-playbook local.yml
```

## Targets

- neovim
- tmux
- zsh

## Dependencies

For installation of dotfiles:
- ansible

Used in shell scripts:
- curl
- ln
- tar

For installation of java:
- [sdkman](https://sdkman.io)
