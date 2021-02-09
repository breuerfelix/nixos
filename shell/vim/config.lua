require'colorizer'.setup()
require'nvim-web-devicons'.setup{default = true;}

-- lspconfig
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
  }
)

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup{}
lspconfig.gopls.setup{}
lspconfig.rnix.setup{}

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- "all", "maintained" or a list
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = false, },
}

-- compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

-- use custom keybindings to navigate
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<C-j>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<C-k>"
  end
end

vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.s_tab_complete()", {expr = true})

-- autopairs
require('nvim-autopairs').setup()
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils = {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"]()
      return npairs.esc("<c-y>")
    else
      vim.defer_fn(function()
        vim.fn["compe#confirm"]("<cr>")
      end, 20)
      return npairs.esc("<c-n>")
    end
  else
    return npairs.check_break_line_char()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
