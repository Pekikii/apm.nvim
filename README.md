# apm.nvim

This is a Neovim plugin that tracks your keypresses and displays your APM (actions per minute) in the statusline. Unlike Primeagen's plugin, this one works.

## Installation

With [Packer](https://github.com/wbthomason/packer.nvim):
add 
```lua
require('packer').startup(function()
  use 'pekikii/apm.nvim'
end)
require('apm').setup()
```
to your `init.lua`

and call `:PackerInstall`

With [Lazy](https://github.com/folke/lazy.nvim):

```lua
--- Lazy
{
    'pekikii/apm.nvim',
    config = function()
      require('apm').setup()
    end,
}
```

## Integration with statusline plugins like lualine

```lua
--- Inside lualine config
    local apm = require('apm').get_apm_status
    require('lualine').setup {
    sections = {
      lualine_y = { apm }
    }
}

```
