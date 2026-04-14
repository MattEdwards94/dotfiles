return {
  'epwalsh/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '/mnt/c/Users/edwardsm/obsidian/Home',
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
