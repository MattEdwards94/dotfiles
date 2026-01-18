return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>jh", function() harpoon:list():add() end, { desc = "Harpoon: Add file to Harpoon list" })
        vim.keymap.set("n", "<leader>je", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle Harpoon quick menu" })

        vim.keymap.set("n", "<leader>ja", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to Harpoon file 1" })
        vim.keymap.set("n", "<leader>js", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to Harpoon file 2" })
        vim.keymap.set("n", "<leader>jd", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to Harpoon file 3" })
        vim.keymap.set("n", "<leader>jf", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to Harpoon file 4" })
    end
}
