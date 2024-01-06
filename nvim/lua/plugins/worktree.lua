return {
  {
    "SimonNyvall/git-worktree.nvim",
    lazy = false,
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
    end,
  },
}
