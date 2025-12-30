-- Note that this plugin relies on the gh cli tool being installed for authenticationt.
-- See installation instructions at: https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian
return {
    "zbirenbaum/copilot.lua",
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
        suggestion = {
            keymap = {
                accept = false, -- handled by nvim-cmp / blink.cmp
                next = "<M-]>",
                prev = "<M-[>",
            },
        },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}
