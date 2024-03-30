return {
  {
    -- fsharp text highlighting
    "SimonNyvall/fsharp-vim",
  },

  {
    -- ionide-fsharp
    "ionide/Ionide-vim",
    config = function()
      vim.g["fsharp#lsp_recommended_colorscheme"] = 0
      vim.g["fsharp#linter"] = 1
      vim.g["fsharp#unused_opens_analyzer"] = 1
    end,
  },
}
