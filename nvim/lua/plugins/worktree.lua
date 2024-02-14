return {
  {
    "SimonNyvall/git-worktree.nvim",
    lazy = false,
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
    end,
    keys = {
      { "n", "<leader>gws", "lua require('telescope').extensions.git_worktree.git_worktrees()" },
    },
  },
}
