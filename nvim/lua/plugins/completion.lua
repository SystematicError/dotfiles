local cmp = require "cmp"

-- Icons taken from NVChad
local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Table = " ",
    Object = "",
    Tag = " ",
    Array = " ",
    Boolean = "蘒",
    Number = "",
    String = "",
    Calendar = "",
    Watch = "",
}

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },

    sources = {
        {name = "nvim_lsp"},
        {name = "nvim_lsp_signature_help"},
        {name = "luasnip"},
        {name = "buffer"},
        {name = "path"},
    },

    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    },

    formatting = {
        format = function(_, item)
            item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
            return item
        end
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        ghost_text = true
    }
}

cmp.setup.cmdline(":", {
    sources = {{name="cmdline"}}
})

cmp.setup.cmdline("/", {
    sources = {{name="buffer"}}
})

require("luasnip.loaders.from_vscode").lazy_load {
    paths = {
        vim.fn.stdpath("data") .. "/site/pack/packer/start/friendly-snippets"
    }
}

return require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

