# Dotfiles

Configurations to improve the CLI dev experience.

Core tools:

- [Ghostty](https://ghostty.org/)
- [fish](https://fishshell.com/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [Neovim](https://neovim.io/)
- [Git](https://git-scm.com/)

Supporting TUIs:

- [lazygit](https://github.com/jesseduffield/lazygit)
- [k9s](https://k9scli.io/)

## 📁 XDG Base Directory

The dotfiles leverage and follow the [XDG Base Directory
specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

`XDG_*_HOME` variables are exported by the shell.

## 🔌 Plugins

Use of plugins in core tools is reduced to a minimum. Since plugins are
specific to the respective tool, the tools are configured in a way to have
those plugins auto-installed.

## ⌨️ Key Bindings

Fish and tmux are setup with vi key bindings.

The tmux prefix is `<Ctrl-Space>` following the leader key `<Space>` used in
Neovim.

`<Ctrl-h>`, `<Ctrl-j>`, `<Ctrl-k>` and `<Ctrl-l>` can be used to seamlessly
navigate between Neovim and tmux splits using
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).

## 📋 Clipboard

Fish uses custom key bindings to interact with the system clipboard in normal
mode (using `fish_clipboard_copy` and `fish_clipboard_paste`).

Neovim sets the `clipboard` option to `unnamedplus` to yank and paste to/from
the system clipboard.

Tmux uses terminal features to synchronize copied text with the system
clipboard. See [tmux wiki](https://github.com/tmux/tmux/wiki/Clipboard) for
details.

## 🖥️ Tmux Sessions

To start and switch tmux sessions, [sesh](https://github.com/joshmedeski/sesh)
is used. It lists tmux sessions, configured sessions and zoxide directories.

The picker is started from fish using the `<Ctrl-Space>` key binding. From tmux
it's invoked using `<Ctrl-Space s>`.

## 📦 Dependencies

The dotfiles assume some additional packages to be installed on your system.
Install them using your system's package manager or via
[Homebrew](https://brew.sh/):

- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [sesh](https://github.com/joshmedeski/sesh)
- [workmux](https://workmux.raine.dev/)
- [hunk](https://hunk.dev/)
- [worktrunk](https://worktrunk.dev/)
- [AWS CLI](https://aws.amazon.com/cli/)
- language servers

##  MacOS Keyboard Settings

- Add 'U.S. International - PC' input source
- Change ' Caps Lock' to 'Control' (Keyboard Shortcuts > Modifier Keys)
- Disable keyboard shortcuts for 'Input Sources' (i.e. Ctrl-Space)
- Set 'Key repeat rate' to 'Fast'

## 🛠️ Installation

The dotfiles can be installed using [stow](https://www.gnu.org/software/stow/):

```shell
git clone https://github.com/alimfeld/dotfiles ~/.dotfiles
cd ~/.dotfiles
mkdir -p ~/.config ~/.local/bin ~/.agents/skills ~/.pi/agent/extensions
stow .
```

The directories are created first because they are shared with other sources
(e.g. a work dotfiles repo). Stow links a whole directory when its target does
not exist, so everything below them is linked per app. `.stowrc` supplies
`--target=~ --dotfiles`.
