-- Set the colorscheme
return {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('tokyonight').setup {
            styles = {
                comments = { italic = false }, -- Disable italics in comments
            },
            on_highlights = function(hl, c)
                hl.WinSeparator = { fg = '#898989' }
            end,
        }
        vim.cmd.colorscheme 'tokyonight-night'
    end,
}
