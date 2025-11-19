# Agent Guidelines

## Build & Test
- **Install/Update:** `stow --target=$HOME --dotfiles */` (Run from repo root).
- **Validation:** No automated test suite. Verify syntax manually:
  - Lua: `luac -p nvim/dot-config/nvim/init.lua`
  - Bash: `bash -n bin/dot-local/scripts/tmux-sessionizer`
  - Fish: Fish will report syntax errors on reload (`source ~/.config/fish/config.fish`)
- **Linting:** Neovim Lua config uses `.luarc.json` for LuaLS (LuaJIT runtime).

## Code Style & Conventions
- **Formatting:** 
  - **Lua:** 2-space indentation for Neovim config (see `.editorconfig`).
  - **General:** LF line endings (`end_of_line = lf`), insert final newline.
- **Structure:** Strict adherence to [XDG Base Directory specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
  - Configs go in `package/dot-config/package/...` which maps to `~/.config/package/...`.
  - Scripts go in `bin/dot-local/scripts/...` which maps to `~/.local/scripts/...`.
- **Naming:** Follow tool-specific conventions (`init.lua`, `config.fish`, `tmux.conf`).
- **Lua Globals:** `vim`, `Mini*`, `Snacks`, and `MiniDeps` are recognized globals in Neovim.
- **Comments:** Use decorative section headers in Neovim Lua (see existing box-drawing style).
- **Tools:**
  - Use `stow` with `--dotfiles` flag for symlinking.
  - Minimal plugins; prefer native configs and LSP-based features.
  - Vi-style key bindings in Fish and Tmux; `<Space>` leader in Neovim.
  - LSP: Auto-format on save, native completion with `autotrigger = true`.
