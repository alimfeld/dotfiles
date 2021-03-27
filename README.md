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

Installation time:
- ansible
- npm
- [sdkman](https://sdkman.io)

Runtime:
- curl
- ln
- tar
- [clipboard-cli](https://github.com/sindresorhus/clipboard-cli)
