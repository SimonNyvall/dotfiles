return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = ";",
    mappings = {
      edit = "e",
      delete_mode = "d",
      clear_all_items = "C",
      toggle = "s", -- used as save if separate_save_and_remove is true
      open_vertical = "%",
      open_horizontal = '"',
      quit = "q",
      remove = "x", -- only used if separate_save_and_remove is true
    },
  },
}
