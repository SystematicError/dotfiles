local lsp = require "lspconfig"
local capabilities  = require "plugins.completion"

local server_path = vim.fn.stdpath("data") .. "/lsp_servers/"

lsp.sumneko_lua.setup {
    cmd = {server_path .. "sumneko_lua/extension/server/bin/lua-language-server"},
    capabilities = capabilities,

    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false
            },

            telemetry = {
                enable = false
            }
        }
    }
}

lsp.pylsp.setup {
    cmd = {server_path .. "pylsp/venv/bin/pylsp"},
    capabilities = capabilities,

    settings = {
        pylsp = {
            configurationSources = {"flake8"},

            plugins = {
                flake8 = {
                    enabled = true,
                    maxLineLength = 120,

                    ignore = {
                        "W391" -- Blank line at end of file
                    }
                },

                mccabe = {enabled = false},
                pyflakes = {enabled = false},
                pycodestyle = {enabled = false}
            }
        }
    }
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl
    })
end


