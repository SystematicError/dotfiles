require "impatient"

require "general"
require "colors"

-- TODO: Lazy loading

require("packer").startup {{
    -- Plugin management
    "wbthomason/packer.nvim",

    -- Improve startup times
    "lewis6991/impatient.nvim",

    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function() require "plugins.lsp" end
    },

    -- LSP server management
    "williamboman/nvim-lsp-installer",

    -- Completion (+ snippets)
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        }
    },

    -- Better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {"lua", "python"}
            }
        end
    }
    },

    -- Packer config
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        display = {
            open_fn = function()
                return require("packer.util").float {border = "rounded"}
            end
        }
    }
}

require "packer_compiled"

