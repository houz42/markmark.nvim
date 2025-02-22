# MarkMark.nvim

Hey everyone! MarkMark.nvim is my first Neovim plugin, brought to life with the help of [avante.nvim](https://github.com/yetone/avante.nvim).
This plugin is designed specifically for navigating Markdown files, offering commands to quickly jump to headers, code blocks, and tables, making it a breeze to move through large documents.

## Features

- Jump to the next or previous header.
- Jump to the next or previous code block.
- Jump to the next or previous table.

## Installation

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

To install MarkMark.nvim using Lazy, add the following to your `plugins/markmark.nvim.lua`:

```lua
return {
  'houz42/markmark.nvim',
  ft = 'markdown',  -- Load the plugin only for markdown files
  config = function()
    require('markmark').setup({
      keybindings = {
        -- Your customized keybindings here
        -- I know you're running out of keys on your keyboard
      }
    })
  end
}
```

### Using [Packer.nvim](https://github.com/wbthomason/packer.nvim)

Add the following to your `init.lua` or `init.vim`:

```lua
use {
  'houz42/markmark.nvim',
  config = function()
    require('markmark').setup()
  end,
  ft = 'markdown'  -- Load the plugin only for markdown files
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

Add the following to your `init.vim`:

```vim
augroup markmark
  autocmd!
  autocmd FileType markdown Plug 'houz42/markmark.nvim'
augroup ENDim
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

## Keybindings

### Default Keybindings

MarkMark.nvim comes with the following default keybindings for navigating Markdown files:

- `]#`: Jump to the next header
- `[#`: Jump to the previous header
- `]```: Jump to the next code block
- `[```: Jump to the previous code block
- `]|`: Jump to the next table
- `[|`: Jump to the previous table

### Customizing Keybindings

You can customize the keybindings by passing a configuration table to the `setup` function. Here is an example of how to customize the keybindings:

```lua
require('markmark').setup({
  keybindings = {
    next_header = "]H",
    prev_header = "[H",
    next_code = "]C",
    prev_code = "[C",
    next_table = "]T",
    prev_table = "[T",
  }
})
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you encounter any bugs or have feature requests.

## License

This plugin is licensed under the MIT License. See [LICENSE](LICENSE) for more information.

## Acknowledgments
