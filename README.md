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
