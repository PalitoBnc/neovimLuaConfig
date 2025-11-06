--Nvim Options:

--about lines
vim.opt.number = false --set to true/false to show or not numbers
vim.opt.relativenumber = false --set to true/false to show or not relativenumbers
vim.opt.wrap = false --set to true/false to wrap or not lines

--about tabs
vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

--about behaviour
vim.opt.scrolloff = 5 --sets the srcolloff off the cursor
vim.opt.splitbelow = true --set to true/flase to new splits splt at the bottom or not
vim.opt.splitright = true --set to true/flase to new splits splt at the right or not
vim.opt.virtualedit = "block" --only in visual block mode, virtual editing is enabled
-- vim.opt.inccommand = "split" --when replacing a word, a preview window will be shown
vim.opt.ignorecase = true --recognize commands even in lowercase (for search only)

--about keybinds

--keybinds already in use:
-->>treesitter
-- "<Leader>ss"
-- "<Leader>si"
-- "<Leader>sd"
-- "<Leader>sc"
-->>lsp
--"<Leader>go"
--"<Leader>ii"
-->>telescope
--"<Leader>ff"
--"<Leader>fg"
--"<Leader>fb"
--"<Leader>fh"
--"<Leader>fa"
--"<Leader>ga"
-->>other
--"<Leader>ch"
--"<A-down>"
--"<A-up>"
--"<A-j>"
--"<A-k>"

-->>Leader:
vim.g.mapleader = "ç"
-->>lsp
vim.api.nvim_set_keymap("n", "<Leader>go", ":lua vim.lsp.buf.definition()<Enter>", {noremap = false})
vim.api.nvim_set_keymap("n", "<Leader>ii", ":lua vim.lsp.buf.hover()<Enter>", {noremap = false})
-->>telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>ga', function ()
    local opts = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",          -- Include hidden files
            "--no-ignore",        -- Ignore .gitignore and .ignore files
            "--follow",           -- Follow symlinks
        },
    }
    builtin.live_grep(opts)
end, { desc = 'Telescope grep all' })
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({
        cwd = vim.fn.expand("~"),
        hidden = true,
        no_ignore = true,
    })
end, { desc = 'Telescope find all files' })
-->>other
vim.api.nvim_set_keymap("n", "<Leader>ch", ":noh<Enter>", {noremap = false})
vim.api.nvim_set_keymap("n", "<A-down>", "ddp", {noremap = false})
vim.api.nvim_set_keymap("n", "<A-up>", "ddkP", {noremap = false})
vim.api.nvim_set_keymap("n", "<A-j>", "ddp", {noremap = false})
vim.api.nvim_set_keymap("n", "<A-k>", "ddkP", {noremap = false})

--about diagnostics
vim.diagnostic.config({
    virtual_text = false, --display text at the rigt of the screen for diagnostics
    virtual_lines = true --display text at the bottom of the lines for diagnostics
})

--about appearence
vim.opt.termguicolors = true --allows more colors in the terminal
-->>removes background:
vim.cmd [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
]]

--Testing 
print("Initializing init.lua!")
