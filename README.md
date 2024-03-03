# My nvim config
Heavily based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), but modularized and with more plugins.

## Dependencies
Neovim `winget install neovim`

- Git (for Lazy) `winget install git.git`
- fd (for Telescope and VenvSelect) `winget install sharkdp.fd`
- Ripgrep (for Telescope) `winget install ripgrep.gnu`
- Any [C compiler](https://winlibs.com) (for treesitter and fzf-native)
- Make (for fzf-native) `winget install ezwinports.make`
- tree-sitter-cli (for treesitter) `npm i -g tree-sitter-cli`
  - Node.js & NPM `winget install openjs.nodejs.lts`
