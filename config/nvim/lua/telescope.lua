local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, '<cmd>Telescope ' .. rhs .. '<cr>', { noremap = true })
end

map('ff', 'find_files')
map('fg', 'git_files')
map('fr', 'live_grep')
map('fb', 'buffers')
map('fh', 'help_tags')
