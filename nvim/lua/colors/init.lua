local module = {}

function module.set_colorscheme(colorscheme_name)
    local colors = require("colors.themes." .. colorscheme_name)

    -- Note that not every shade or accent may be used
    local a = colors.accents
    local s = colors.shades

    -- Consult http://neovim.io/doc/user/builtin.html#synIDattr() for the subtable styles
    -- Template adapted from https://github.com/Iron-E/nvim-highlite
    -- TODO: Add more highlights
    local highlights = {
        -- (Core) Text Analysis
        Comment = {fg = s.gray_light, italic = true},
        NonText = {fg = s.gray},
        EndOfBuffer = {fg = s.bg},

        PMenu = {bg = "#151515"},
        PMenuSel = {bg = "#303030"}
    }

    for group, style in pairs(highlights) do
        if type(style) == "string" then
            vim.cmd(string.format("hi! link %s %s", group, style))
        else
            vim.api.nvim_set_hl(0, group, style)
        end
    end
end

return module
