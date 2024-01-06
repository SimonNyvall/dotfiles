return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    keys = {
      { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add current line to harpoon" },
      { "<leader>hf", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle harpoon quick manu" },
    },
  },
}
