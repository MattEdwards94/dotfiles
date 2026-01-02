return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('codecompanion').setup {
            extensions = {
            },
            rules = {
                default = {
                    description = "Collection of common files for all projects",
                    files = {
                        ".clinerules",
                        ".cursorrules",
                        ".goosehints",
                        ".rules",
                        ".windsurfrules",
                        ".github/copilot-instructions.md",
                        "AGENT.md",
                        "AGENTS.md",
                        { path = "CLAUDE.md", parser = "claude" },
                        { path = "CLAUDE.local.md", parser = "claude" },
                        { path = "~/.claude/CLAUDE.md", parser = "claude" },
                    },
                    is_preset = true,
                },
                opts = {
                    chat = {
                        enabled = true,
                        default_rules = "default", -- The rule groups to load
                    },
                },
            },
            interactions = {
                chat = {
                    tools = {
                        ["cmd_runner"] = {
                            opts = {
                                allowed_in_yolo_mode = true,
                            },
                        },
                        opts = {
                            default_tools = {
                                "full_stack_dev",
                                "files"
                            },
                        },
                    },
                    adapter = {
                        name = 'copilot',
                        model = 'gemini-3-pro-preview',
                    },
                },
                inline = {
                    adapter = {
                        name = 'copilot',
                        model = 'gemini-3-pro-preview',
                    },
                },
                agent = {
                    adapter = {
                        name = 'copilot',
                        model = 'gemini-3-pro-preview',
                    },
                },
                keymaps = {
                    send = {
                        modes = { n = { '<C-s>', '<C-l>' }, i = { '<C-s>', '<C-l>', '<C-Enter>' } },
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
