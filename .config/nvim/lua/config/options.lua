-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Blinking cursor in insert mode when idle
vim.opt.guicursor = "n-v-c-sm:block-blinkon0,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20-blinkon0"

-- Force dark theme regardless of frontend. Neovide on macOS would otherwise
-- read system Light/Dark appearance and flip jb.nvim to its light variant.
vim.opt.background = "dark"
