# Dotfiles

Configurations to improve the CLI dev experience.

Core tools:

- [WezTerm](https://wezfurlong.org/wezterm/)
- [Z Shell (zsh)](https://www.zsh.org/)
- [Neovim](https://neovim.io/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [Git](https://git-scm.com/)

Supporting TUIs:

- [lazygit](https://github.com/jesseduffield/lazygit)
- [k9s](https://k9scli.io/)

## 📁 XDG Base Directory

The dotfiles try to leverage and follow the XDG Base Directory specification.

Since zsh only offers partial support for XDG, we still have a `.zshenv` in the
home directory.

## ⚙️ Custom Initialization

Any custom shell initialization (such as `eval "$(brew shellenv)"`) should be
put in `~/.config/zsh/.zprofile`.

## 🔌 Plugins

Use of plugins in core tools is reduced to a minimum. Since plugins are
specific to the respective tool, the tools are configured in a way to have
those plugins auto-installed.

**Z Shell** plugins are listed in `.zshrc` and are automatically installed (and
loaded) when the shell starts. The following functions are defined to manage
plugins:

- `zsh-plugins-install`
- `zsh-plugins-update`
- `zsh-plugins-remove`

**Neovim** is configured to use [lazy.nvim](https://github.com/folke/lazy.nvim)
for installing and managing plugins.

## ⌨️ Key Bindings

Z Shell and tmux are setup with vi key bindings.

The tmux prefix is `<Ctrl-Space>` following the leader key `<Space>` used in
Neovim.

`<Ctrl-h>`, `<Ctrl-j>`, `<Ctrl-k>` and `<Ctrl-l>` can be used to seamlessly
navigate between Neovim and tmux splits using
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).

Key bindings in Neovim can be explored via
[WhichKey](https://github.com/folke/which-key.nvim).

## 📋 Clipboard

Z Shell uses
[zsh-system-clipboard](https://github.com/kutsan/zsh-system-clipboard) to
synchronize the system clipboard with ZLE buffers.

Neovim sets the `clipboard` option to `unnamedplus` to yank and paste to/from
the system clipboard.

Tmux uses terminal features to synchronize copied text with the system
clipboard. See [tmux wiki](https://github.com/tmux/tmux/wiki/Clipboard) for
details.

## 🖥️ Tmux Sessions

To start and switch to tmux sessions based on directories under '~/dev', the
`tmux-sessionizer` script is used. This script is heavily inspired by
[ThePrimagen's
tmux-sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)

The script is started from zsh using the `<Ctrl-Space>` key binding. From tmux
it's invoked using `<Ctrl-Space Tab>`.

## 📦 Dependencies

The dotfiles assume the following additional packages to be installed on your
system:

General purpose tools:

- [fzf](https://github.com/junegunn/fzf)

Language servers:

- [gopls](https://github.com/golang/tools/tree/master/gopls)
- [lua-language-server](https://github.com/luals/lua-language-server)
- [marksman](https://github.com/artempyanykh/marksman)
- [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
- [terraform-ls](https://github.com/hashicorp/terraform-ls)

Formatters:

- [black](https://github.com/psf/black)
- [gofmt (go)](https://github.com/golang/go)
- [isort](https://github.com/PyCQA/isort)
- [prettier](https://github.com/prettier/prettier)
- [stylua](https://pkg.go.dev/golang.org/x/tools/gopls)
- [terraform fmt](https://github.com/hashicorp/terraform)

Linters:

- [pylint](https://github.com/pylint-dev/pylint)
- [shellcheck](https://github.com/koalaman/shellcheck)

You can install the packages using your systems's package manager or via
[Homebrew](https://brew.sh/).

## 🛠️ Installation

The dotfiles can be installed using [stow](https://www.gnu.org/software/stow/):

```shell
git clone https://github.com/alimfeld/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow */
```
