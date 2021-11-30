-- local function title()
--     return vim.loop.cwd()
--     -- return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
-- end

require("luatab").setup {
    -- title = title

    modified = function()
        return ""
    end,
    windowCount = function()
        return ""
    end
    -- devicon = function() return '' end,
    -- separator = function() return '' end,
}
