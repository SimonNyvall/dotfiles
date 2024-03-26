vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

local dap_text = require("nvim-dap-virtual-text")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.fs", "*.fsx", "*.fsi", "fsharp" },
  callback = function()
    dap_text.disable()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function() end,
})
