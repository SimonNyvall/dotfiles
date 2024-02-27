local dap_text = require("nvim-dap-virtual-text")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fsharp",
  callback = function()
    dap_text.disable()
    vim.g["fsharp#backend"] = "disable"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    dap_text.disable()
  end,
})
