lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
  indent = {
    enable = true
  },
}
EOF

set foldmethod=expr
set foldexpr=nvmi_treesitter#foldexpr()
