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
        path = '~/notes/Home/',
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
