return {
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jb",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Override lualine_a to match the mode color box on the right
      -- instead of the pink ProjectColor
      opts.options = opts.options or {}
      opts.options.theme = vim.deepcopy(require("lualine.themes.jb"))
      for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }) do
        if opts.options.theme[mode] then
          opts.options.theme[mode].a = opts.options.theme[mode].z
        end
      end
    end,
  },
}
