# indentation-multiline.nvim
NeoVim Plugin written in Lua to indent multilines in an easy way.

## Features

- Indent selected lines in VISUAL mode.

## Install

- Requires neovim version 0.7 abode.
- Requires plenary feature.
- Install this plugin like any other Vim plugin, e.g. with [packer.nvim](https://github.com/wbthomason/packer.nvim):
  ```lua
  local use = require('packer').use
  require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager
    use { 'joshnavru/indentation-multiline', requires = 'nvim-lua/plenary.nvim' }
  end)
  ```

## Usage

By default this feature create the followind mappings in VISUAL mode:

- `<Tab>`: Indent to the right.
- `<S-Tab>`: Indent to the left.

## Configuration

This plugin needs to be initialised using:

```lua
require('indentation-multiline').setup()
```

However you can pass config options, the defaults are:
```lua
{
  -- Mapping for right-intent
  indent_mapping = "<Tab>",
  -- Mapping for left-intent
  unindent_mapping = "<S-Tab>",
}
```

## Last
This is my first plugin for Vim using Lua, if you see any way to improve I will appreciate the advices.
