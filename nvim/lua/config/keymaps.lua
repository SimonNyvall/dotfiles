vim.keymap.set("n", "<leader>t", "<cmd>Trouble<cr>", { desc = "Open truble" })

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })

-- Split right and split below the window should be the same as in tmux
vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Split right" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Split below" })

vim.keymap.set("n", "<F5>", "<cmd>edit!<cr>", { desc = "Reload buffer" })

vim.keymap.set(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd(), file_ignore_patterns = {'node_modules', '%.dll$', '.cache', 'obj', 'bin'} })<cr>",
  { desc = "Find file" }
)

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostics" })

-- Line break at cursor
vim.keymap.set("n", "M", "i<cr><esc>", { desc = "Line break at cursor" })

vim.keymap.set("n", "mk", "ddkP", { desc = "Move line up" })
vim.keymap.set("n", "mj", "ddp", { desc = "Move line down" })

-- Harpoon keymaps
local harpoon = require("harpoon")
harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>hh", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():append()
end)

vim.keymap.set("n", "<leader>hd", function()
  harpoon:list():remove()
end)

-- CMP keymaps
local cmp = require("cmp")
local cmpConf = cmp:get_config()
cmpConf.mapping = vim.tbl_deep_extend("force", cmpConf.mapping, {
  ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-y>"] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }),
})
