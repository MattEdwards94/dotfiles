return {
    'olimorris/codecompanion.nvim',
    opts = {
        extensions = {
            vectorcode = {
                opts = {
                    add_tool = true,
                }
            }
        }
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        {
            "Davidyz/VectorCode",
            version = "*",
            cmd = {
                "VectorCode",
            },
        }
    },
    config = function()
        require('codecompanion').setup {
            extensions = {
                vectorcode = {
                    opts = {
                        add_tool = true,
                    }
                }
            },
            strategies = {
                chat = {
                    adapter = 'copilot',
                },
                inline = {
                    adapter = 'copilot',
                },
                agent = {
                    adapter = 'copilot',
                },
                keymaps = {
                    send = {
                        modes = { n = '<C-s>', i = { '<C-s>', '<C-CR>' } },
                    },
                    close = {
                        modes = { n = '<C-c>', i = '<C-c>' },
                    },
                },
            },
            adapters = {
                gemini = function()
                    return require('codecompanion.adapters').extend('gemini', {
                        schema = {
                            model = {
                                default = 'gemini-2.0-flash',
                            },
                        },
                        env = {
                            api_key = 'GEMINI_API_KEY',
                        },
                    })
                end,
            },
        }
    end,
}
