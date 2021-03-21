# Dotfiles

Mainly shell (zsh) and neovim so far...

## Installation

The dotifiles are installed with ansible:

```shell
ansible-pull -K -U https://github.com/alimfeld/dotfiles
```

or (once pulled):

```shell
cd ~/dotfiles
ansible-playbook -K local.yml
```
