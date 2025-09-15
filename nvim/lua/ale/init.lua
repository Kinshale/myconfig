require("ale.opt")
require("ale.keymap")

require("ale.lazy_init")

vim.api.nvim_create_autocmd('textyankpost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 100,
        })
    end,
})
