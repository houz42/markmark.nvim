# MarkMark.nvim

Hey everyone! MarkMark.nvim is my first Neovim plugin, brought to life with the help of [avante.nvim](https://github.com/yetone/avante.nvim).
This plugin is designed specifically for navigating Markdown files, offering commands to quickly jump to headers, code blocks, and tables, making it a breeze to move through large documents.
And guess what? It works in avante.nvim's output stream!

## Features

- Jump to the next or previous header.
- Jump to the next or previous code block.
- Jump to the next or previous table.

## Installation

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  { "houz42/markmark.nvim" },
  ---- adding additional file types here, e.g., Avante for Avante.nvim output stream.
  ft = { "markdown", "Avante" },
  opts = {},
  ---- Override default keybindings
  -- keys = {
  --   { "]#", ":MarkMarkNextHeader<CR>", desc = "Next Header" },
  --   { "[#", ":MarkMarkPrevHeader<CR>", desc = "Previous Header" },
  --   { "]`", ":MarkMarkNextCode<CR>", desc = "Next Code Block" },
  --   { "[`", ":MarkMarkPrevCode<CR>", desc = "Previous Code Block" },
  --   { "]|", ":MarkMarkNextTable<CR>", desc = "Next Table" },
  --   { "[|", ":MarkMarkPrevTable<CR>", desc = "Previous Table" },
  -- },
}
```

### Using [Packer.nvim](https://github.com/wbthomason/packer.nvim)

Add the following to your `init.lua` or `init.vim`:

```lua
use {
  'houz42/markmark.nvim',
  ft = { 'markdown', 'avante' },
  config = function()
    require('markmark').setup({
      -- Add any configuration options here
    })
    -- -- Manually override keybindings
    -- vim.api.nvim_set_keymap('n', ']#', ':MarkMarkNextHeader<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '[#', ':MarkMarkPrevHeader<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', ']`', ':MarkMarkNextCode<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '[`', ':MarkMarkPrevCode<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', ']|', ':MarkMarkNextTable<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '[|', ':MarkMarkPrevTable<CR>', { noremap = true, silent = true })
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

Add the following to your `init.vim`:

```vim
call plug#begin('~/.vim/plugged')
Plug 'houz42/markmark.nvim'
call plug#end()

augroup markmark_config
  autocmd!
  autocmd FileType markdown,avante lua require('markmark').setup({
    -- Add any configuration options here
  })
augroup END

" " Manually override keybindings
"nnoremap ]# :MarkMarkNextHeader<CR>
"nnoremap [# :MarkMarkPrevHeader<CR>
"nnoremap ]` :MarkMarkNextCode<CR>
"nnoremap [` :MarkMarkPrevCode<CR>
"nnoremap ]| :MarkMarkNextTable<CR>
"nnoremap [| :MarkMarkPrevTable<CR>
```

Then run `:PlugInstall` to install the plugin.

## Usage

Once installed, you can use the following commands to navigate your Markdown files:

| Command               | Action                          |
| --------------------- | ------------------------------- |
| `:MarkMarkNextHeader` | Jump to the next header         |
| `:MarkMarkPrevHeader` | Jump to the previous header     |
| `:MarkMarkNextCode`   | Jump to the next code block     |
| `:MarkMarkPrevCode`   | Jump to the previous code block |
| `:MarkMarkNextTable`  | Jump to the next table          |
| `:MarkMarkPrevTable`  | Jump to the previous table      |

## Default Keybindings

MarkMark.nvim comes with the following default keybindings for navigating Markdown files:

- `]#`: Jump to the next header
- `[#`: Jump to the previous header
- ``]` `` : Jump to the next code block
- ``[` ``: Jump to the previous code block
- `]|`: Jump to the next table
- `[|`: Jump to the previous table

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you encounter any bugs or have feature requests.

## License

This plugin is licensed under the MIT License. See [LICENSE](LICENSE) for more information.

## Acknowledgments
