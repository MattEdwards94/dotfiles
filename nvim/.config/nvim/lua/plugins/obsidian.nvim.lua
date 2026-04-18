return {
    'epwalsh/obsidian.nvim',
    version = '*',
    ft = 'markdown',
    cmd = { "ObsidianToday" },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    opts = {
        workspaces = {
            {
                name = 'personal',
                path = '/mnt/c/Users/edwardsm/obsidian/obsidian_notes/',
            },
        },
        daily_notes = {
            folder = 'dailies',
            date_format = '%Y-%m-%d',
        },
        templates = {
            folder = 'templates',
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
    },
}
