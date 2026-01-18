-- =============== [[ Basic Keymaps ]] =============== --
require("snacks")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- keep the cursor in the middle of the page for j, k, and searching
vim.keymap.set('n', 'j', 'jzz')
vim.keymap.set('n', 'k', 'kzz')

-- recentre when stepping through searches
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- recentre when paging up or down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- jj to exit insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

-- LSP Hierarchy
vim.keymap.set('n', 'gho', vim.lsp.buf.outgoing_calls, { desc = 'Hierarchy out' })
vim.keymap.set("n", "ghh", function()
  require("snacks").picker.pick {
    title = "LSP Incoming Calls",
    finder = function(opts, ctx)
      local lsp = require "snacks.picker.source.lsp"
      local Async = require "snacks.picker.util.async"
      local win = ctx.filter.current_win
      local buf = ctx.filter.current_buf
      local bufmap = lsp.bufmap()

      ---@async
      ---@param cb async fun(item: snacks.picker.finder.Item)
      return function(cb)
        local async = Async.running()
        local cancel = {} ---@type fun()[]

        async:on(
          "abort",
          vim.schedule_wrap(function()
            vim.tbl_map(pcall, cancel)
            cancel = {}
          end)
        )

        vim.schedule(function()
          -- First prepare the call hierarchy
          local clients = lsp.get_clients(buf, "textDocument/prepareCallHierarchy")
          if vim.tbl_isempty(clients) then return async:resume() end

          local remaining = #clients
          for _, client in ipairs(clients) do
            local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
            local status, request_id = client:request("textDocument/prepareCallHierarchy", params, function(_, result)
              if result and not vim.tbl_isempty(result) then
                -- Then get incoming calls for each item
                local call_remaining = #result
                if call_remaining == 0 then
                  remaining = remaining - 1
                  if remaining == 0 then async:resume() end
                  return
                end

                for _, item in ipairs(result) do
                  local call_params = { item = item }
                  local call_status, call_request_id = client:request(
                    "callHierarchy/incomingCalls",
                    call_params,
                    function(_, calls)
                      if calls then
                        for _, call in ipairs(calls) do
                          ---@type snacks.picker.finder.Item
                          local item = {
                            text = call.from.name .. "    " .. call.from.detail,
                            kind = lsp.symbol_kind(call.from.kind),
                            line = "    " .. call.from.detail,
                          }
                          local loc = {
                            uri = call.from.uri,
                            range = call.from.range,
                          }
                          lsp.add_loc(item, loc, client)
                          item.buf = bufmap[item.file]
                          item.text = item.file .. "    " .. call.from.detail
                          ---@diagnostic disable-next-line: await-in-sync
                          cb(item)
                        end
                      end
                      call_remaining = call_remaining - 1
                      if call_remaining == 0 then
                        remaining = remaining - 1
                        if remaining == 0 then async:resume() end
                      end
                    end
                  )
                  if call_status and call_request_id then
                    table.insert(cancel, function() client:cancel_request(call_request_id) end)
                  end
                end
              else
                remaining = remaining - 1
                if remaining == 0 then async:resume() end
              end
            end)
            if status and request_id then table.insert(cancel, function() client:cancel_request(request_id) end) end
          end
        end)

        async:suspend()
        cancel = {}
        async = Async.nop()
      end
    end,
  }
end, { desc = "LSP incoming function calls" })

-- allows paste without the delete overwriting the register
vim.keymap.set('x', '<leader>p', [["_dP]])

-- yanks into the system register
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- quickfix navigation
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')

-- Delete to void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

vim.keymap.set('n', 'Q', '<nop>')

-- Open a new tmux session in the selected folder - requires tmux-sessionizer bash script
vim.keymap.set('n', '<leader>fs', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- obsidian
vim.keymap.set('n', '<leader>oh', '<cmd>edit ~/notes/Home/Home.md<CR>', { desc = '[obsidian] Open Home' })


-- Format whole page
vim.keymap.set('n', 'fp', 'gg=G<C-o>', { desc = 'Format page and go back to prev location' })

-- CodeCompanion shortcuts
vim.keymap.set({ 'n', 'v' }, '<leader>at', '<cmd>CodeCompanionChat Toggle<CR><cmd>set winwidth=70<CR>', { desc = '[CodeCompanion] Toggle chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>an', '<cmd>CodeCompanionChat<CR><cmd>set winwidth=70<CR>', { desc = '[CodeCompanion] New chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ae', '<cmd>CodeCompanion /explain<CR>', { desc = '[CodeCompanion] Explain selected code' })
vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<CR>', { desc = '[CodeCompanion] Show actions' })
vim.keymap.set('v', '<leader>aca', '<cmd>CodeCompanionChat Add<CR>', { desc = '[CodeCompanion] Add to chat' })

-- Terminal keymaps
vim.keymap.set("n", "<C-t>", function() Snacks.terminal() end, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- vim.keymap.set('t', '<C-space>', '<C-\\><C-n><C-w>p', { desc = 'Switch back to last buffer from terminal' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +4<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -4<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -4<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +4<cr>', { desc = 'Increase Window Width' })

-- Move Lines
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- saner-behavior-of-n-and-N
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- better indenting, keeps lines highlighted for multiple tabbing
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

--new file
vim.keymap.set('n', '<C-n>', '<cmd>enew<cr>', { desc = 'New File' })

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- windows
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
--Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<c-n>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', {noremap = true, silent = true})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use H and L to move between buffers
vim.keymap.set('n', 'H', '<cmd>bprevious<cr>', { desc = 'Move to previous buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<cr>', { desc = 'Move to next buffer' })

-- toggle option
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.animate():map('<leader>ua')
Snacks.toggle.indent():map('<leader>ug')
Snacks.toggle.scroll():map('<leader>uS')
Snacks.toggle.zoom():map('<leader>wm')

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map('<leader>uh')
end


-- tmux sessionizer keymaps
-- vim.keymap.del("n", "<C-f>") -- remove default keymap
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
vim.keymap.set("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

vim.keymap.set("i", "<M-c>", function()
  local nldocs = require("noice.lsp.docs")
  local message = nldocs.get("signature")
  nldocs.hide(message)
end)


vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) 

-- Open git diff view
vim.keymap.set('n' , '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Git Diffview Open' })

