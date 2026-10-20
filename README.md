# Dotfiles

Configurations to improve the CLI dev experience.

## 🎯 Strategy

- **Keep `$HOME` clean.** Config, state and cache live in the standard
  [XDG](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
  directories; `$HOME` holds only the few paths a tool forces.
- **No vendored plugin code.** Tools install and update their own; this repo
  stores config.
- **One set of keys.** The same vi motions everywhere, with `<Space>` as the
  editor leader and `<Ctrl-Space>` as the terminal prefix.
- **One clipboard.** Copy in one tool, paste in another.
- **One session per worktree.** Every piece of work is isolated and restorable,
  with its own agent and diff.
- **One look.** Gruvbox-like colours everywhere.

## 🧰 Tools

### [Ghostty](https://ghostty.org/)

Terminal.

### [zsh](https://www.zsh.org/)

Shell. Vi mode, autosuggestions, syntax highlighting, [starship](https://starship.rs/)
prompt, [zoxide](https://github.com/ajeetdsouza/zoxide) jumps and
[direnv](https://direnv.net/) per-directory environments.

### [tmux](https://github.com/tmux/tmux/wiki)

Multiplexer, with a [sesh](https://github.com/joshmedeski/sesh) +
[fzf](https://github.com/junegunn/fzf) session picker, a
[workmux](https://workmux.raine.dev/) dashboard and sidebar, and split
navigation that reaches into Neovim.

### [Neovim](https://neovim.io/)

Editor. Plugins install themselves on first start; language servers start per
file type.

### [Git](https://git-scm.com/)

Version control, with Neovim as the difftool and
[lazygit](https://github.com/jesseduffield/lazygit) for interactive use.

### [pi](https://pi.dev/)

Agent, installed separately.
[workmux](https://workmux.raine.dev/) turns a worktree into a tmux session
holding pi.

## 🍎 macOS Keyboard Settings

- Add 'U.S. International - PC' input source
- Change ' Caps Lock' to 'Control' (Keyboard Shortcuts > Modifier Keys)
- Disable keyboard shortcuts for 'Input Sources' (i.e. Ctrl-Space)
- Set 'Key repeat rate' to 'Fast'

## 🛠️ Installation

Requires [Homebrew](https://brew.sh/). Install with
[stow](https://www.gnu.org/software/stow/):

```shell
chsh -s /bin/zsh  # Ghostty and tmux use the login shell
git clone https://github.com/alimfeld/dotfiles ~/.dotfiles
cd ~/.dotfiles
mkdir -p ~/.config ~/.local/bin ~/.agents/skills ~/.pi/agent/extensions
./dot-local/bin/brew-install  # core tools, dependencies and language servers
stow .
# then install pi (see pi.dev) — workmux runs it — and run `workmux setup` for its pi status extension
```

The directories are created first because they are shared with other stow
sources (e.g. a work dotfiles repo).

Machine-local overrides go in `~/.config/local/` (`zsh.zsh`, `tmux.conf`),
which zsh and tmux source if present. Another repo can own that directory,
e.g. a work dotfiles repo stowing `dot-config/local`. Git, Neovim and Ghostty
have their own untracked spots: `~/.gitconfig`, `~/.local/share/nvim/site/plugin/` and
`~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`.
