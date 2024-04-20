---@diagnostic disable: redefined-local
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.o.relativenumber = true
vim.o.cursorline = true

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.fn.sign_define("DiagnosticSignError", {text = "", numhl = "DiagnosticError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", numhl = "DiagnosticWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", numhl = "DiagnosticInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", numhl = "DiagnosticHint"})


vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })

vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Split right" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Split below" })

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostics" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "EdenEast/nightfox.nvim" },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"williamboman/mason.nvim"},
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "jay-babu/mason-nvim-dap.nvim"
    },
    {"neovim/nvim-lspconfig"},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { "github/copilot.vim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        }
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        }
    },
    {
        "echasnovski/mini.diff"
    },
    {
        "christoomey/vim-tmux-navigator"
    },
    {
        "folke/trouble.nvim",
        branch = "dev"
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },
    {
        "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
    }
}
local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>gg", builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
   ensure_installed = {"lua", "javascript", "c_sharp", "typescript", "html", "bash", "markdown", "markdown_inline"},
   highlight = { enable = true },
   indent = { enable = true }
})

require("mason").setup({
    ensure_installed = {
        "htmlint",
        "fantomas",
        "prettier",
        "clang-format",
        "csharpier",
        "harper-ls",
        "luaformatter",
        "css-lsp",
        "html-lsp",
        "bash-language-server",
    }
})

local config = require("mason-lspconfig")
config.setup({
    ensure_installed = {
        "lua_ls",
        "omnisharp",
        "fsautocomplete",
        "tsserver",
        "clangd",

    }
})

local masondap = require("mason-nvim-dap")
masondap.setup({
    ensure_installed = {
        "netcoredbg",
        "bash-debug-adapter",
    }
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
    capabilities = capabilities
})

lspconfig.omnisharp.setup({
    capabilities = capabilities
})

lspconfig.fsautocomplete.setup({
    capabilities = capabilities
})

lspconfig.tsserver.setup({
    capabilities = capabilities
})

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

local config = require("telescope")
config.setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    }
})

require("telescope").load_extension("ui-select")


local cmp = require("cmp")
cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })

vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["lua"] = false,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
    ["f#"] = true,
}

local diff = require("mini.diff")
diff.setup({
    view = {
        style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    }
})

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window up" })


local harpoon = require("harpoon")
harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>hh", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end)

vim.keymap.set("n", "<leader>hd", function()
  harpoon:list():remove()
end)


local trouble = require("trouble")
trouble.setup({
modes = {
    mydiags = {
      mode = "diagnostics",
      filter = {
        any = {
          buf = 0,
          {
            severity = vim.diagnostic.severity.ERROR,
            function(item)
              return item.filename:find(vim.loop.cwd(), 1, true)
            end,
          },
        },
      },
    }
    }
})

vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<cr>")

require("dapui").setup()

vim.keymap.set("n", "<leader>du", function() require("dapui").toggle({ }) end)
vim.keymap.set("n", "<leader>de", function() require("dapui").eval() end)

vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
vim.keymap.set("n", "<leader>da", function() require("dap").continue({ before = get_args }) end)
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end)
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end)
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end)
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end)
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end)
vim.keymap.set("n", "<leader>do", function() require("dap").run_last() end)
vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end)
vim.keymap.set("n", "<leader>dp", function() require("dap").pause() end)
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end)
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end)
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end)
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end)


require("lualine").setup()

require("nightfox").setup()
vim.cmd.colorscheme "nightfox"
