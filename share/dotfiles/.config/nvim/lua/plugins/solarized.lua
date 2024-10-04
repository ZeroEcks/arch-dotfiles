return {
  {
    "vimpostor/vim-lumen",
  },
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      palette = "selenized",
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      require("solarized").setup(opts)
      vim.cmd.colorscheme("solarized")
    end,
  },
}
