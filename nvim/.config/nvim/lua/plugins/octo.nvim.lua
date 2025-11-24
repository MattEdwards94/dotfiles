return {
    'pwntester/octo.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
        'folke/snacks.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()
        require('octo').setup({
            picker = "fzf-lua",
        })
    end,
    keys = {
        {"<leader>goil", ":Octo issue list<CR>", desc = "List issues"},
        {"<leader>goip", ":Octo issue create<CR>", desc = "Create issue"},
        {"<leader>goic", ":Octo issue close<CR>", desc = "Close issue"},
        {"<leader>goid", ":Octo issue delete<CR>", desc = "Delete issue"},
        {"<leader>gois", ":Octo issue search<CR>", desc = "Search issues"},
        {"<leader>goib", ":Octo issue browser<CR>", desc = "Open issue in browser"},

        {"<leader>gopl", ":Octo pr list<CR>", desc = "List PRs"},
        {"<leader>gopp", ":Octo pr create<CR>", desc = "Create PR"},
        {"<leader>gopc", ":Octo pr close<CR>", desc = "Close PR"},
        {"<leader>gopd", ":Octo pr delete<CR>", desc = "Delete PR"},
        {"<leader>gops", ":Octo pr search<CR>", desc = "Search PRs"},

        {"<leader>gors", ":Octo review start<CR>", desc = "Open review"},
        {"<leader>gorc", ":Octo review continue<CR>", desc = "Continue review"},
        {"<leader>gorx", ":Octo review discard<CR>", desc = "Discard review"},
        {"<leader>gorq", ":Octo review submit<CR>", desc = "Submit review"},
    }
}
