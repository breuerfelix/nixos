require'colorizer'.setup()
require('gitsigns').setup()

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- "all", "maintained" or a list
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = false, },
  rainbow = { enable = true, },
}

--require'nvim-web-devicons'.setup{default = true;}
