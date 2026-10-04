---@diagnostic disable: redefined-local
---@diagnostic disable: undefined-global
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.opt.clipboard:append("unnamedplus")

vim.cmd([[highlight MatchParen cterm=none guibg=none guifg=none ctermbg=none ctermfg=none]])

-- Set line numbers and cursor line
vim.o.relativenumber = true
vim.opt.number = true
vim.o.cursorline = true

-- Set up fuzzy search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set up the theme
vim.cmd("colorscheme habamax")
vim.cmd("highlight ModeMsg ctermfg=10 guifg=#00ff00 guibg=NONE ctermbg=NONE")

-- Highlight on yank
vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankHighlight",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- Set tab width to 4 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.g.netrw_banner = 0

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = ""
    },
    update_in_insert = true,
    signs = false,
    underline = true
})

-- Set up general keymaps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search" })

vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Split right" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Split below" })

vim.keymap.set("n", "<leader>r", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open diagnostics" })

vim.keymap.set("n", "mk", "ddkP")
vim.keymap.set("n", "mj", "ddp")

-- Set up whitespace render
vim.opt.list = true
vim.opt.listchars = {
    lead = "·",
    tab = "→ ",
    trail = " ",
}

-- Set up lazy package manager
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

-- Set up plugins
local plugins = {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },
    { "williamboman/mason.nvim" },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
    },
    { "neovim/nvim-lspconfig" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "github/copilot.vim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "echasnovski/mini.diff",
    },
    {
        "christoomey/vim-tmux-navigator",
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
    },
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
    },
    {
        "ionide/Ionide-vim",
    },
    {
        "echasnovski/mini.map",
    },
    {
        "max397574/startup.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local startup = require("startup")

            startup.setup({
                theme = "evil",
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash"
            },

            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter"
            },

            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash"
            },

            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search"
            },

            {
                "<C-s>",
                mode = "c",
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search"
            },

            {
                "<leader>s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash Jump"
            },
        },
    },
}

require("lazy").setup(plugins, opts)

-- Minimap
local minimap = require("mini.map")

minimap.setup({
    integrations = {
        minimap.gen_integration.diff(),
        minimap.gen_integration.builtin_search(),
        minimap.gen_integration.gitsigns(),
        minimap.gen_integration.diagnostic(),
    },
    symbols = {
        encode = minimap.gen_encode_symbols.dot("4x2"),
    },
    window = {
        side = "right",
        width = 10,
        winblend = 15,
        show_integration_count = false,
    },
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function(args)
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
                return
            end

            if vim.bo[args.buf].filetype == "startup" then
                minimap.close()
            else
                minimap.open()
            end
        end)
    end,
})

-- Treesitter
require("nvim-treesitter").install({
    "lua",
    "javascript",
    "c_sharp",
    "typescript",
    "html",
    "bash",
    "markdown",
    "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
                return
            end

            vim.api.nvim_buf_call(args.buf, function()
                vim.cmd("filetype detect")
            end)
        end)
    end,
})

-- Set up telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", function()
    builtin.find_files({
        hidden = false,
        no_ignore = false,
    })
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})

-- Set up mason
require("mason").setup();

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "roslyn_ls",
        "ts_ls",
    },
})

-- Set up LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- C / C++
vim.lsp.config("clangd", {
    capabilities = capabilities,
})

-- JavaScript / TypeScript
vim.lsp.config("ts_ls", {
    capabilities = capabilities,
})

-- Enable the servers
vim.lsp.enable({
    "lua_ls",
    "clangd",
    "roslyn_ls",
    "ts_ls",
})

-- Set up mason-dap
local masondap = require("mason-nvim-dap")
masondap.setup({
    ensure_installed = {
        "netcoredbg",
        "bash-debug-adapter",
    },
})


vim.api.nvim_set_hl(0, "DapBreakpointRed", {
    fg = "#8B0000",
})

vim.fn.sign_define("DapBreakpoint", {
    text = "●",
    texthl = "DapBreakpointRed",
    linehl = "",
    numhl = "",
})

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
end, { noremap = true, silent = true })

local config = require("telescope")
config.setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

require("telescope").load_extension("ui-select")

-- Set up cmp
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
})

-- Set up copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { expr = true, silent = true })
vim.g.copilot_enabled = 1

-- Set up diff for git
local diff = require("mini.diff")
diff.setup({
    view = {
        style = "sign",
        signs = {
            add = "▎",
            change = "▎",
            delete = "",
        },
    },
})

-- Set up tmux navigator
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window up" })

-- Set up harpoon2
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
    harpoon:list():clear()
end, { desc = "Clear harpoon" })

-- Set up dap and dapui
local dap = require("dap")
local dapui = require("dapui")

local telescope = require("telescope")

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

-- Add Mason executables to PATH
vim.env.PATH = mason_bin
    .. (vim.fn.has("win32") == 1 and ";" or ":")
    .. vim.env.PATH

-- ============================================================================
-- netcoredbg
-- ============================================================================

local netcoredbg = vim.fn.exepath("netcoredbg")

if netcoredbg == "" then
    vim.notify(
        "netcoredbg not found. Install it with :MasonInstall netcoredbg",
        vim.log.levels.ERROR
    )
else
    dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg,
        args = { "--interpreter=vscode" },
        options = {
            detached = false,
        },
    }
end

-- ============================================================================
-- DAP UI
-- ============================================================================

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

dapui.setup()

-- ============================================================================
-- Find solution/project root
-- ============================================================================

local function find_solution_root()
    local cwd = vim.fn.getcwd()

    -- First check the current directory
    local solutions = vim.fn.globpath(cwd, "*.sln", false, true)
    local slnx = vim.fn.globpath(cwd, "*.slnx", false, true)

    if #solutions > 0 or #slnx > 0 then
        return cwd
    end

    -- Then walk upwards from the current file
    local file = vim.api.nvim_buf_get_name(0)

    if file == "" then
        return cwd
    end

    local dir = vim.fn.fnamemodify(file, ":p:h")

    while dir ~= "" do
        local sln = vim.fn.globpath(dir, "*.sln", false, true)
        local slnx_files = vim.fn.globpath(dir, "*.slnx", false, true)

        if #sln > 0 or #slnx_files > 0 then
            return dir
        end

        local parent = vim.fn.fnamemodify(dir, ":h")

        if parent == dir then
            break
        end

        dir = parent
    end

    return cwd
end

-- ============================================================================
-- Find all projects in the solution
-- ============================================================================

local function find_projects()
    local root = find_solution_root()

    return vim.fn.globpath(
        root,
        "**/*.csproj",
        false,
        true
    )
end

-- ============================================================================
-- Find built DLLs for a project
-- ============================================================================

local function find_dlls(csproj)
    local project_dir = vim.fn.fnamemodify(csproj, ":h")
    local project_name = vim.fn.fnamemodify(csproj, ":t:r")

    local dlls = vim.fn.globpath(
        project_dir .. "/bin",
        "**/" .. project_name .. ".dll",
        false,
        true
    )

    local result = {}

    for _, dll in ipairs(dlls) do
        if not dll:match("[\\/]ref[\\/]") then
            table.insert(result, dll)
        end
    end

    return result
end

-- ============================================================================
-- Start debugging a DLL
-- ============================================================================

local function debug_dll(dll)
    dap.run({
        type = "coreclr",
        name = "Launch .NET",
        request = "launch",

        program = dll,

        cwd = vim.fn.fnamemodify(dll, ":h"),

        stopAtEntry = false,

        console = "integratedTerminal",
    })
end

-- ============================================================================
-- Select DLL
-- ============================================================================

local function select_dll(csproj)
    local dlls = find_dlls(csproj)

    if #dlls == 0 then
        vim.notify(
            "No built DLL found. Build the project first.",
            vim.log.levels.WARN
        )
        return
    end

    if #dlls == 1 then
        debug_dll(dlls[1])
        return
    end

    telescope.find_files({
        prompt_title = "Select DLL to Debug",

        cwd = vim.fn.fnamemodify(csproj, ":h") .. "/bin",

        find_command = {
            "fd",
            "--type",
            "f",
            "--extension",
            "dll",
        },

        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local actions = require("telescope.actions")

                local entry = action_state.get_selected_entry()

                actions.close(prompt_bufnr)

                if entry then
                    debug_dll(entry.path or entry.value)
                end
            end)

            return true
        end,
    })
end

-- ============================================================================
-- Select project
-- ============================================================================

local function dotnet_debug()
    local projects = find_projects()

    if #projects == 0 then
        vim.notify(
            "No .csproj files found in the solution.",
            vim.log.levels.ERROR
        )
        return
    end

    -- Only one project -> skip the project picker
    if #projects == 1 then
        select_dll(projects[1])
        return
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "Select .NET Project",

            finder = require("telescope.finders").new_table({
                results = projects,

                entry_maker = function(project)
                    local display = vim.fn.fnamemodify(
                        project,
                        ":~:."
                    )

                    return {
                        value = project,
                        display = display,
                        ordinal = display,
                    }
                end,
            }),

            sorter = require("telescope.config").values.generic_sorter({}),

            attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                local function select_project()
                    local entry = action_state.get_selected_entry()

                    actions.close(prompt_bufnr)

                    if entry then
                        select_dll(entry.value)
                    end
                end

                actions.select_default:replace(select_project)

                map("i", "<CR>", select_project)

                return true
            end,
        })
        :find()
end

-- ============================================================================
-- F5 = select project -> select DLL -> debug
-- ============================================================================

vim.keymap.set("n", "<F5>", dotnet_debug, {
    desc = "Debug .NET project",
})

-- ============================================================================
-- DAP keymaps
-- ============================================================================

vim.keymap.set("n", "<leader>du", function()
    dapui.toggle({})
end, { desc = "Toggle DAP UI" })

vim.keymap.set("n", "<leader>de", function()
    dapui.eval()
end, { desc = "DAP Eval" })

vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(
        vim.fn.input("Breakpoint condition: ")
    )
end, { desc = "Conditional breakpoint" })

vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

vim.keymap.set("n", "<leader>da", function()
    dap.continue()
end, { desc = "Continue" })

vim.keymap.set("n", "<leader>dC", function()
    dap.run_to_cursor()
end, { desc = "Run to cursor" })

vim.keymap.set("n", "<F11>", function()
    dap.step_into()
end, { desc = "Step into" })

vim.keymap.set("n", "<leader>dj", function()
    dap.down()
end, { desc = "Down stack frame" })

vim.keymap.set("n", "<leader>dk", function()
    dap.up()
end, { desc = "Up stack frame" })

vim.keymap.set("n", "<leader>dl", function()
    dap.run_last()
end, { desc = "Run last" })

vim.keymap.set("n", "<F10>", function()
    dap.step_over()
end, { desc = "Step over" })

vim.keymap.set("n", "<leader>dp", function()
    dap.pause()
end, { desc = "Pause" })

vim.keymap.set("n", "<leader>dr", function()
    dap.repl.toggle()
end, { desc = "Toggle REPL" })

vim.keymap.set("n", "<leader>ds", function()
    dap.session()
end, { desc = "DAP session" })

vim.keymap.set("n", "<leader>dt", function()
    dap.terminate()
end, { desc = "Terminate" })

vim.keymap.set("n", "<leader>dw", function()
    require("dap.ui.widgets").hover()
end, { desc = "DAP hover" })

dapui.setup()

-- Copilot status and Lualine setup
local function is_copilot_loaded()
    return package.loaded["copilot"] ~= nil
end

local function copilot_status()
    if not is_copilot_loaded() then
        return "  "
    else
        return "  "
    end
end

local function copilot_color()
    if not is_copilot_loaded() then
        return { fg = "#111111" } -- White is loaded
    else
        return { fg = "#ff0000" } -- Red if not loaded
    end
end

local function refresh_statusline()
    vim.api.nvim_command("redrawstatus")
end

local function setup_periodic_refresh()
    vim.defer_fn(function()
        refresh_statusline()
        setup_periodic_refresh()
    end, 5000)
end

setup_periodic_refresh()

local function lsp_client_names()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return "󰒏 "
    end -- Show 'No LSP' if no clients are attached

    local client_names = {}
    for _, client in pairs(clients) do
        if string.lower(client.name) ~= "github copilot" then
            table.insert(client_names, client.name)
        end
    end
    return table.concat(client_names, ", ")
end

require("lualine").setup({
    sections = {
        lualine_x = {
            { lsp_client_names, color = { fg = "#111111", gui = "italic" } },
            { copilot_status,   color = copilot_color },
        },
        lualine_c = {
            { "filename", path = 1, color = { fg = "#111111" } },
        },
    },
})

-- Formatting on save
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        csharp = { "csharpier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        fsharp = { "fantomas" },
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 2000,
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
