local dap_text = require("nvim-dap-virtual-text")

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fsharp",
  callback = function()
    dap_text.disable()
  end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWritePost" }, {
  pattern = "fsharp",
  callback = function()
    vim.g["fsharp#backend"] = "disable"
    vim.g["fsharp#show_signature_on_cursor_move"] = 1
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function() end,
})
