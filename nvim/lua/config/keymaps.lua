vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })

vim.keymap.set("n", "<leader>ld", "<cmd>TroubleToggle<cr>", { desc = "Open truble" })

vim.keymap.set(
  "n",
  "<leader>gw",
  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { desc = "Open worktree" }
)
vim.keymap.set(
  "n",
  "<leader>gc",
  "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
  { desc = "Create worktree" }
)

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

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

vim.keymap.set("n", "mk", "ddkP", { desc = "Move line up" })
vim.keymap.set("n", "mj", "ddp", { desc = "Move line down" })
