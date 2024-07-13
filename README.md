# My nvim config
Heavily based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), but modularized and with more plugins.

## Windows Dependencies
Neovim >= 0.10.0 `winget install neovim`

- Git (for Lazy) `winget install git.git`
- [Nerd font](https://www.nerdfonts.com/font-downloads)
- fd (for Telescope and VenvSelect) `winget install sharkdp.fd`
- Ripgrep (for Telescope) `winget install ripgrep.gnu`
- Any [C compiler](https://winlibs.com) (for treesitter and fzf-native)
- Make (for fzf-native) `winget install ezwinports.make`
- tree-sitter-cli (for treesitter) `npm i -g tree-sitter-cli`
  - Node.js & NPM (for markdown-preview and coc) `winget install openjs.nodejs.lts`

## Linux Dependencies
- [Nerd font](https://www.nerdfonts.com/font-downloads)
- fd (for Telescope and VenvSelect) `sudo apt install fd-find && echo 'alias fd="fdfind"' >> ~/.zshrc`
- [Ripgrep](https://github.com/BurntSushi/ripgrep/releases) (for Telescope)
- Node.js & NPM (for markdown-preview and coc)
  - Node Version Manager
    ```
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install --lts
    ```
