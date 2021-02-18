require'colorizer'.setup()

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- "all", "maintained" or a list
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = true, },
}

