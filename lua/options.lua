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
vim.g.mapleader = "ç"

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
