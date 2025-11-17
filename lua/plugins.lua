--Plugins:

--Plugin Manager Lazy:

--sets up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Instalando lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

--plugins:
require("lazy").setup({
    {
        "sontungexpt/witch",
        config = function()
            vim.cmd.colorscheme("witch-dark")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup ({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cpp", "rust" },

                auto_install = true,

                highlight = {
                    enable = true,
                    disable = { "csv", "tsv",},
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss", --set to false to disable one of the mappings
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },
  		        textobjects = {
    			    select = {
      				    enable = true,

      				    -- Automatically jump forward to textobj, similar to targets.vim
      				    lookahead = true,

      				    keymaps = {
        				    -- You can use the capture groups defined in textobjects.scm
        				    ["af"] = "@function.outer",
        				    ["if"] = "@function.inner",
        				    ["ac"] = "@class.outer",
        				    -- You can optionally set descriptions to the mappings (used in the desc parameter of
        				    -- nvim_buf_set_keymap) which plugins like which-key display
        				    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        				    -- You can also use captures from other query groups like `locals.scm`
        				    ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      				    },
      				    -- You can choose the select mode (default is charwise 'v')
      				    --
      				    -- Can also be a function which gets passed a table with the keys
      				    -- * query_string: eg '@function.inner'
      				    -- * method: eg 'v' or 'o'
      				    -- and should return the mode ('v', 'V', or '<c-v>') or a table
      				    -- mapping query_strings to modes.
      				    selection_modes = {
        				    ['@parameter.outer'] = 'v', -- charwise
        				    ['@function.outer'] = 'V', -- linewise
        				    ['@class.outer'] = '<c-v>', -- blockwise
      				    },
      				    -- If you set this to `true` (default is `false`) then any textobject is
      				    -- extended to include preceding or succeeding whitespace. Succeeding
      				    -- whitespace has priority in order to act similarly to eg the built-in
      				    -- `ap`.
      				    --
      				    -- Can also be a function which gets passed a table with the keys
      					-- * query_string: eg '@function.inner'
      					-- * selection_mode: eg 'v'
      					-- and should return true or false
      					include_surrounding_whitespace = true,
    				},
  			    },
        	})
		end,
	},
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("jdtls")
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (Ctrl + y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'super-tab' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = {'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
       "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- ícones bonitinhos
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto", -- pega o tema atual
                    section_separators = "",
                    component_separators = "",
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
            require("telescope").setup({
            })
        end,
    },
    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function ()
            require("ufo").setup({
                provider_selector = function (bufnr, filetype, buftype)
                    return { "lsp", "indent" }
                end,
            })
        end,
    },
})
