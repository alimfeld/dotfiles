local theme = {}

function theme.setup()
    vim.cmd([[colorscheme gruvbox-material]])
    require'lualine'.setup {
        options = {
            theme= 'gruvbox-material'
        }
    }
end

return theme
