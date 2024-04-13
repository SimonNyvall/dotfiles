return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["C-j"] = cmp.mapping.select_next_item()
      opts.mapping["C-k"] = cmp.mapping.select_prev_item()
      opts.mapping["<C-a>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
      opts.mapping["<CR>"] = function(fallback)
        if cmp.visible() then
          cmp.abort()
          -- Insert a newline
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
        else
          fallback()
        end
      end
    end,
  },
}
