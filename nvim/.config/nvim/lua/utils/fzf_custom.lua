local M = {}

---Files picker that shows recently visited files (scoped to cwd) first,
---then falls through to all files via fd. Fuzzy search still works across everything.
function M.files_mru()
    local fzf = require('fzf-lua')
    local cwd = vim.fn.getcwd()
    local cwd_prefix = cwd .. '/'

    local recent = {}
    local seen = {}
    for _, f in ipairs(vim.v.oldfiles) do
        local abs = vim.fn.fnamemodify(f, ':p')
        if vim.fn.filereadable(abs) == 1 and abs:sub(1, #cwd_prefix) == cwd_prefix then
            local rel = abs:sub(#cwd_prefix + 1)
            if not seen[rel] then
                seen[rel] = true
                table.insert(recent, rel)
            end
        end
    end

    local fd_cmd = 'fd --color=never --type f --hidden --follow --exclude .git'
    local cmd
    if #recent > 0 then
        local quoted = table.concat(vim.tbl_map(function(p)
            return "'" .. p:gsub("'", "'\\''") .. "'"
        end, recent), ' ')
        cmd = string.format("{ printf '%%s\\n' %s; %s; } | awk '!seen[$0]++'", quoted, fd_cmd)
    else
        cmd = fd_cmd
    end

    fzf.files({
        cmd = cmd,
        fzf_opts = { ['--tiebreak'] = 'index' },
        formatter = 'path.filename_first',
        prompt = '󰋚 Files (recent first) > ',
    })
end

function M.live_grep_in_selected_dir()
  -- Define the base directory for the directory picker (where fd starts searching)
  -- Using vim.fn.expand('~') is more robust than "~" directly for internal Lua paths.
  local picker_start_dir = vim.fn.expand('~')

  require("fzf-lua").fzf_exec(
    "fd --type d --max-depth 10 --hidden -L", -- This command will be run with 'picker_start_dir' as its cwd
    {
      cwd = picker_start_dir, -- Set the working directory for the 'fd' command
      prompt = "Select directory to grep in > ",
      actions = {
        ["default"] = function(selected_dir_table)
          if selected_dir_table and selected_dir_table[1] then
            local relative_path = selected_dir_table[1] -- e.g., "my_project/src"

            -- IMPORTANT: Construct the absolute path
            -- Use vim.fs.joinpath for robust path concatenation
            local absolute_selected_path = vim.fs.joinpath(picker_start_dir, relative_path)

            -- Now, pass the absolute path to live_grep's cwd option
            require("fzf-lua").live_grep({ cwd = absolute_selected_path })
          end
        end,
      },
    }
  )
end

return M
